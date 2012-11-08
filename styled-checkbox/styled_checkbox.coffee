
$ ->

  $.fn.styledCheckbox = ()->
    $(this).each ()->
        $this = $(this)
        $this.hide()
        styled = $('<span>').addClass 'styled-checkbox'
        styled.html '&nbsp;'
        if $this.is ':checked'
          styled.addClass 'styled-checkbox-checked'
        $this.after styled
        return if $(this).prop 'disabled'
        styled.on 'click', (e)->
          styled.toggleClass 'styled-checkbox-checked'
          $this.click()

  $('input[type="checkbox"]').styledCheckbox()
