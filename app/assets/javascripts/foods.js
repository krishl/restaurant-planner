$(document).on('turbolinks:load', function() {
  if ($('body').is('.userShow')) {
    $("div.sorted_foods").hide()
    attachFListeners()
  }

  if ($('body').is('.foodShow')) {
    var foodIndex = $(".js-nextf").data("fidx")
    nextFood(foodIndex)
  }
})

function attachFListeners() {
  $("a#sort_foods").on("click", function(event) {
    event.preventDefault();
    $.getJSON(this.href).success(function(json) {
      $("div.sorted_foods").toggle()
      $("div.sorted_restaurants").hide()
      foodDetails(json)
    })
  })
}

function foodDetails(json) {
  var userId = $('center').data('user-id');
  var $table = $("div.sorted_foods table tbody")
  $table.html("")

  json.forEach(function(food) {
    $table.append(`<tr>
      <td><a href="/users/${userId}/foods/${food.id}">${food.name}</td>
      <td><a data-confirm="Are you sure?" rel="nofollow" data-method="delete" href="/users/${userId}/foods/${food.id}">Remove All</a></td>
    </tr>`)
  })
  checkFEmpty($table.html)
}

function checkFEmpty(table) {
  if (table === "") {
    $("table.table").hide()
    $("p#empty").remove()
    $("div.sorted_foods").prepend("<p id='empty'><br>You currently do not have any menu item plans.</p>")
  }
}

function nextFood(foodIndex) {
  $(".js-nextf").on("click", function(event) {
    event.preventDefault();
    var userId = $('.js-nextf').data('uid');
    var foodArray = $(".js-nextf").data("ufoods");
    foodIndex += 1;
    var nextId = foodArray[foodIndex];

    $.getJSON(`/users/${userId}/foods/${nextId}`, function(food) {
      $("h1.fName").text(food.name)
      $("ul.fRestaurants").html("")

      food.restaurants.forEach(function(food, i) {
        var rListItem = `<li><a href="/users/${userId}/foods/${food.id}">${food.name}</a> <span id="fPrice${i}"></span> | <span id="fDelete${i}"></span>`
        $("ul.fRestaurants").append(rListItem)
      })

      food.restaurant_foods.forEach(function(restaurant_food, i) {
        $(`span#fPrice${i}`).text(`${accounting.formatMoney(restaurant_food.price)}`)
        $(`span#fDelete${i}`).html(`<a data-confirm="Are you sure?" rel="nofollow" data-method="delete" href="/restaurant_foods/${restaurant_food.id}">Delete</a>`)
      })
    }).fail(function() {
      alert("You have reached the end.")
    })
  })
}
