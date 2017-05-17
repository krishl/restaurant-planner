$(document).on('turbolinks:load', function() {
  if ($('body').is('.userShow')) {
    $("div.sorted_foods").hide()
    $("div.new_food").hide()
    foodIndexListeners()
  }

  if ($('body').is('.foodShow')) {
    var foodIndex = $(".js-nextf").data("fidx")
    nextFood(foodIndex)
  }
})

function foodIndexListeners() {
  $("a#sort_foods").on("click", function(event) {
    event.preventDefault();
    $.getJSON(this.href).success(function(json) {
      $("div.sorted_foods").toggle()
      $("div.sorted_restaurants").hide()
      foodDetails(json)
    })
  })

  $("a#add_new_food").on("click", function(event) {
    event.preventDefault();
    $("div.new_food").toggle()
  })

  $("form#foodForm").submit(function(event) {
    event.preventDefault();
    var userId = $('center').data('user-id');
    var values = $(this).serialize()
    var postingFood = $.post(`/users/${userId}/foods`, values)
    postingFood.done(function(data) {
      newFood(data)
      $("#foodSubmit").attr('disabled', false);
    })
    $("form").trigger("reset")
    $("div.new_food").hide()
  })
}

function foodDetails(json) {
  var userId = $('center').data('user-id');
  var $table = $("div.sorted_foods table tbody")
  $table.html("")

  json.forEach(function(food) {
    newFood(food)
  })
  checkFEmpty()
}

function checkFEmpty() {
  if ($('tbody').is(':empty')) {
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

      food.restaurants.forEach(function(restaurant, i) {
        var rListItem = `<li><a href="/users/${userId}/restaurants/${restaurant.id}">${restaurant.name}</a> <span id="fPrice${i}"></span> | <span id="fDelete${i}"></span>`
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

function newFood(data) {
  var food = new Food(data)
  food.newRow()
}

class Food {
  constructor(data) {
    this.id = data.id
    this.name = data.name
  }
}

Food.prototype.newRow = function() {
  var $table = $("div.sorted_foods table tbody")
  var userId = $('center').data('user-id');
  var newRow = `<tr>
    <td><a href="/users/${userId}/foods/${this.id}">${this.name}</td>
    <td><a data-confirm="Are you sure?" rel="nofollow" data-method="delete" href="/users/${userId}/foods/${this.id}">Remove All</a></td>
  </tr>`
  $table.append(newRow)
  $("p#empty").remove()
  $("table.table").show()
}
