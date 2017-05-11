$(document).ready(function() {
  attachListeners()
})

function attachListeners() {
  $("#sort_foods").on("click", function() {
    sortFoods()
  })
}
