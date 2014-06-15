class JpgRanger.GridView extends Ember.View
  templateName: 'grid'
  table: ~>
    grid = []
    @controller.model.forEach (x, idx) ->
      row = Math.floor(idx / 6)
      col = idx % 6
      if col is 0
        grid[row] = []
      grid[row][col] = x
    grid