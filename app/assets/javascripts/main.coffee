# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ = jQuery

$ ->
  doAddressQuery = ->
    $('.query-result-container').hide()
    $('.query-error').hide()
    form = $('.address-query-form form')
    address = form.find('input[name="address_location[address]"]').val()
    $.ajax
      type: 'POST'
      url: '/address'
      data: {address_location: {address: address}}
      success: (data) ->
        if data.address_location?
          $.ajax
            type: 'GET'
            url: '/get_i18n'
            data: {key: 'main.result.your_locator'}
            success: (val) ->
              $('.query-result-title').html(val.i18n)
              $('.query-result').html(data.address_location.locator)
              $('.query-result-container').show()
        else if data.error?
          if data.error == 'empty_coordinates'
            $.ajax
              type: 'GET'
              url: '/get_i18n'
              data: {key: 'errors.empty_coordinates'}
              success: (val) ->
                $('.query-error').html(val.i18n)
                $('.query-error').show()
          else
            $.ajax
              type: 'GET'
              url: '/get_i18n'
              data: {key: 'errors.unknown'}
              success: (val) ->
                $('.query-error').html(val.i18n)
                $('.query-error').show()

  doIpQuery = ->
    $('.query-result-container').hide()
    $('.query-error').hide()
    form = $('.ip-query-form form')
    ip = form.find('input[name="ip_location[ip]"]').val()
    $.ajax
      type: 'POST'
      url: '/ip'
      data: {ip_location: {ip: ip}}
      success: (data) ->
        if data.ip_location?
          $.ajax
            type: 'GET'
            url: '/get_i18n'
            data: {key: 'main.result.your_locator'}
            success: (val) ->
              $('.query-result-title').html(val.i18n)
              $('.query-result').html(data.ip_location.locator)
              $('.query-result-container').show()
        else if data.error?
          if data.error == 'empty_coordinates'
            $.ajax
              type: 'GET'
              url: '/get_i18n'
              data: {key: 'errors.empty_coordinates'}
              success: (val) ->
                $('.query-error').html(val.i18n)
                $('.query-error').show()
          else
            $.ajax
              type: 'GET'
              url: '/get_i18n'
              data: {key: 'errors.unknown'}
              success: (val) ->
                $('.query-error').html(val.i18n)
                $('.query-error').show()

  doPureQuery = ->
    $('.query-result-container').hide()
    $('.query-error').hide()
    form = $('.pure-query-form form')
    latitude = form.find('input[name="pure_location[latitude]"]').val()
    longitude = form.find('input[name="pure_location[longitude]"]').val()
    $.ajax
      type: 'POST'
      url: '/pure'
      data: {pure_location: {latitude: latitude, longitude: longitude}}
      success: (data) ->
        if data.pure_location?
          $.ajax
            type: 'GET'
            url: '/get_i18n'
            data: {key: 'main.result.your_locator'}
            success: (val) ->
              $('.query-result-title').html(val.i18n)
              $('.query-result').html(data.pure_location.locator)
              $('.query-result-container').show()
        else if data.error?
          if data.error == 'empty_coordinates'
            $.ajax
              type: 'GET'
              url: '/get_i18n'
              data: {key: 'errors.empty_coordinates'}
              success: (val) ->
                $('.query-error').html(val.i18n)
                $('.query-error').show()
          else
            $.ajax
              type: 'GET'
              url: '/get_i18n'
              data: {key: 'errors.unknown'}
              success: (val) ->
                $('.query-error').html(val.i18n)
                $('.query-error').show()

  doReverseQuery = ->
    $('.query-result-container').hide()
    $('.query-error').hide()
    form = $('.reverse-query-form form')
    locator = form.find('input[name="reverse_location[locator]"]').val()
    $.ajax
      type: 'POST'
      url: '/reverse'
      data: {reverse_location: {locator: locator}}
      success: (data) ->
        if data.reverse_location?
          $.ajax
            type: 'GET'
            url: '/get_i18n'
            data: {key: 'main.reverse_result.your_address'}
            success: (val) ->
              $('.query-result-title').html(val.i18n)
              $('.query-result').html(data.reverse_location.reverse_address)
              $('.query-result-container').show()
        else if data.error?
          if data.error == 'empty_coordinates'
            $.ajax
              type: 'GET'
              url: '/get_i18n'
              data: {key: 'errors.empty_coordinates'}
              success: (val) ->
                $('.query-error').html(val.i18n)
                $('.query-error').show()
          else
            $.ajax
              type: 'GET'
              url: '/get_i18n'
              data: {key: 'errors.unknown'}
              success: (val) ->
                $('.query-error').html(val.i18n)
                $('.query-error').show()

  $(document).on 'click', '.address-query-form form input[type="submit"]', (e) ->
    e.preventDefault()
    doAddressQuery()

  $(document).on 'click', '.ip-query-form form input[type="submit"]', (e) ->
    e.preventDefault()
    doIpQuery()

  $(document).on 'click', '.pure-query-form form input.pure-query-submit[type="submit"]', (e) ->
    e.preventDefault()
    doPureQuery()

  $(document).on 'click', '.reverse-query-form form input[type="submit"]', (e) ->
    e.preventDefault()
    doReverseQuery()