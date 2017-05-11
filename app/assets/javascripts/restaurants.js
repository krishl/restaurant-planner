$(document).ready(function() {
  attachListeners()
})

function attachListeners() {
  $("#sort_restaurants").on("click", function() {
    sortRestaurants()
  })
}
