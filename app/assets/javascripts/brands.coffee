# ---------------------------------
class App.BrandSelect

  constructor: (element_id) ->
    @element = $(element_id)
    @build_select()

  build_select: ->
    @element.normalSelect
      data: @element.data('data')
      placeholder: 'Buscar Marca...'
      createSearchChoicePosition: 'bottom'
      createSearchChoice: (term, page) ->
        unless page.some(((item) ->
            item.text.toLowerCase() == term.toLowerCase()
          ))
          return {
            id: term
            text: "#{term} (Nuevo)"
            name: term
            isNew: true
          }
  update: (brand_id, brand_name) ->
    brands = @element.data 'data'
    brands.push { id: brand_id, text: brand_name }
    @element.data('data', brands)
    @build_select()
    @element.select2('val', brand_id)



