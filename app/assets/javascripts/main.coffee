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
      url: '/api/address'
      data: {address: address}
      success: (data) ->
        if data.address_location?
          $('.query-result-title').html('Your Maidenhead (QTH) locator is:')
          $('.query-result').html(data.address_location.locator)
          $('.query-result-container').show()
        else if data.error?
          if data.error == 'empty_coordinates'
            $('.query-error').html('Error: Empty coordinates!')
          else
            $('.query-error').html('Unknown error!')
          $('.query-error').show()

  doIpQuery = ->
    $('.query-result-container').hide()
    $('.query-error').hide()
    form = $('.ip-query-form form')
    ip = form.find('input[name="ip_location[ip]"]').val()
    $.ajax
      type: 'POST'
      url: '/api/ip'
      data: {ip: ip}
      success: (data) ->
        if data.ip_location?
          $('.query-result-title').html('Your Maidenhead (QTH) locator is:')
          $('.query-result').html(data.ip_location.locator)
          $('.query-result-container').show()
        else if data.error?
          if data.error == 'empty_coordinates'
            $('.query-error').html('Error: Empty coordinates!')
          else
            $('.query-error').html('Unknown error!')
          $('.query-error').show()

  doPureQuery = ->
    $('.query-result-container').hide()
    $('.query-error').hide()
    form = $('.pure-query-form form')
    latitude = form.find('input[name="pure_location[latitude]"]').val()
    longitude = form.find('input[name="pure_location[longitude]"]').val()
    $.ajax
      type: 'POST'
      url: '/api/pure'
      data: {latitude: latitude, longitude: longitude}
      success: (data) ->
        if data.pure_location?
          $('.query-result-title').html('Your Maidenhead (QTH) locator is:')
          $('.query-result').html(data.pure_location.locator)
          $('.query-result-container').show()
        else if data.error?
          if data.error == 'empty_coordinates'
            $('.query-error').html('Error: Empty coordinates!')
          else
            $('.query-error').html('Unknown error!')
          $('.query-error').show()

  doReverseQuery = ->
    $('.query-result-container').hide()
    $('.query-error').hide()
    form = $('.reverse-query-form form')
    locator = form.find('input[name="reverse_location[locator]"]').val()
    $.ajax
      type: 'POST'
      url: '/api/reverse'
      data: {locator: locator}
      success: (data) ->
        if data.reverse_location?
          $('.query-result-title').html('Your address is:')
          $('.query-result').html(data.reverse_location.reverse_address)
          $('.query-result-container').show()
        else if data.error?
          if data.error == 'empty_coordinates'
            $('.query-error').html('Error: Empty coordinates!')
          else
            $('.query-error').html('Unknown error!')
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