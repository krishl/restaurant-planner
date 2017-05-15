$(document).on('turbolinks:load', function() {
  $("div.sorted_restaurants").hide()
  attachRListeners()
  nextRestaurant()
})

function attachRListeners() {
  $("a#sort_restaurants").on("click", function(event) {
    event.preventDefault();
    $.getJSON(this.href).success(function(json) {
      $("div.sorted_restaurants").toggle()
      $("div.sorted_foods").hide()
      restaurantDetails(json)
    })
  })
}

function restaurantDetails(json) {
  var userId = $('center').data('user-id');
  var $table = $("div.sorted_restaurants table tbody")
  $table.html("")

  json.forEach(function(restaurant) {
    $table.append(`<tr>
      <td><a href="/users/${userId}/restaurants/${restaurant.id}">${restaurant.name}</td>
      <td>${restaurant.address}</td>
      <td>${restaurant.phone}</td>
      <td>${restaurant.cuisine}</td>
      <td><a data-confirm="Are you sure?" rel="nofollow" data-method="delete" href="/users/${userId}/restaurants/${restaurant.id}">Delete</a></td>
    </tr>`)
  })
  checkREmpty($table.html)
}

function checkREmpty(table) {
  if (table === "") {
    $("table.table").hide()
    $("p#empty").remove()
    $("div.sorted_restaurants").prepend("<p id='empty'><br>You currently do not have any restaurant plans.</p>")
  }
}

function nextRestaurant() {
  $(".js-next").on("click", function(event) {
    event.preventDefault();
    var userId = $('p').data('user-id');
    var nextId = parseInt($(".js-next").data("rid")) + 1;
    $.getJSON(`/users/${userId}/restaurants/${nextId}`, function(restaurant) {
      $("h1.rName").text(restaurant.name)
      $("span.rAddress").text(restaurant.address)
      $("span.rCuisine").text(restaurant.cuisine)
      $("span.rPhone").text(restaurant.phone)
      $("span.rBorough").text(restaurant.borough)
      $("ul.rFoods").html("")

      restaurant.foods.forEach(function(food, i) {
        var rListItem = `<li><a href="/users/${userId}/foods/${food.id}">${food.name}</a> <span id="rPrice${i}"></span> | <span id="rDelete${i}"></span>`
        $("ul.rFoods").append(rListItem)
      })

      restaurant.restaurant_foods.forEach(function(restaurant_food, i) {
        $(`span#rPrice${i}`).text(`${accounting.formatMoney(restaurant_food.price)}`)
        $(`span#rDelete${i}`).html(`<a data-confirm="Are you sure?" rel="nofollow" data-method="delete" href="/restaurant_foods/${restaurant_food.id}">Delete</a>`)
      })
    })
  })
}
