$(document).on('turbolinks:load', function() {
  $("div.sorted_restaurants").hide()
  attachRListeners()
})

function attachRListeners() {
  $("a#sort_restaurants").on("click", function(event) {
    event.preventDefault();
    $.getJSON(this.href).success(function(json) {
      restaurantDetails(json)
    })
  })
}

function restaurantDetails(json) {
  $("div.sorted_restaurants").toggle()
  $("div.sorted_foods").hide()
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
