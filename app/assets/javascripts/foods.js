$(document).on('turbolinks:load', function() {
  $("div.sorted_foods").hide()
  attachFListeners()
})

function attachFListeners() {
  $("a#sort_foods").on("click", function(event) {
    event.preventDefault();
    $.getJSON(this.href).success(function(json) {
      foodDetails(json)
    })
  })
}

function foodDetails(json) {
  $("div.sorted_foods").toggle()
  $("div.sorted_restaurants").hide()
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
  if (table != "") {
    $("table.table").hide()
    $("p#empty").remove()
    $("div.sorted_foods").prepend("<p id='empty'><br>You currently do not have any menu item plans.</p>")
  }
}
