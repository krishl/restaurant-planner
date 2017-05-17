$(document).on('turbolinks:load', function() {
  if ($('body').is('.userShow')) {
    $("div.sorted_restaurants").hide()
    $("div.new_restaurant").hide()
    restaurantIndexListeners()
  }

  if ($('body').is('.restShow')) {
    var restIndex = $(".js-next").data("ridx")
    nextRestaurant(restIndex)
  }
})

function restaurantIndexListeners() {
  $("a#sort_restaurants").on("click", function(event) {
    event.preventDefault();
    $.getJSON(this.href).success(function(json) {
      $("div.sorted_restaurants").toggle()
      $("div.sorted_foods").hide()
      restaurantDetails(json)
    })
  })

  $("a#add_new_rest").on("click", function(event) {
    event.preventDefault();
    $("div.new_restaurant").toggle()
  })

  $("form").submit(function(event) {
    event.preventDefault();
    var userId = $('center').data('user-id');
    var values = $(this).serialize()
    var postingRestaurant = $.post(`/users/${userId}/restaurants`, values)
    postingRestaurant.done(function(data, userId) {
      newRestaurant(data)
    })
    $("form").trigger("reset")
    $("div.new_restaurant").hide()
  })
}

function restaurantDetails(json) {
  var userId = $('center').data('user-id');
  var $table = $("div.sorted_restaurants table tbody")
  $table.html("")

  json.forEach(function(restaurant) {
    newRestaurant(restaurant, userId)
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

function nextRestaurant(restIndex) {
  $(".js-next").on("click", function(event) {
    event.preventDefault();
    var userId = $('.js-next').data('uid');
    var restArray = $(".js-next").data("urests");
    restIndex += 1
    var nextId = restArray[restIndex];
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
    }).fail(function() {
      alert("You have reached the end.")
    })
  })
}

function newRestaurant(data) {
  var restaurant = new Restaurant(data)
  restaurant.newRow()
}

class Restaurant {
  constructor(data) {
    this.id = data.id
    this.name = data.name
    this.address = data.address
    this.phone = data.phone
    this.cuisine = data.cuisine
  }
}

Restaurant.prototype.newRow = function() {
  var $table = $("div.sorted_restaurants table tbody")
  var userId = $('center').data('user-id');
  var newRow = `<tr>
    <td><a href="/users/${userId}/restaurants/${this.id}">${this.name}</td>
    <td>${this.address}</td>
    <td>${this.phone}</td>
    <td>${this.cuisine}</td>
    <td><a data-confirm="Are you sure?" rel="nofollow" data-method="delete" href="/users/${userId}/restaurants/${this.id}">Delete</a></td>
    </tr>`
  $table.append(newRow)
}
