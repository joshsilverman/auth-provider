# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
#  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
#  subscription.setupForm()
#
#subscription =
#  setupForm: ->
#    $('#payment-form').submit ->
#      $('input[type=submit]').attr('disabled', true)
#      if $('#card-number').length
#        subscription.processCard()
#        false
#      else
#        true
#  
#  processCard: ->
#    card =
#      number: $('#card-number').val()
#      cvc: $('#card-cvc').val()
#      expMonth: $('#card-expiry-month').val()
#      expYear: $('#card-expiry-year').val()
#      name: $('#card-holder-name').val()
#    Stripe.createToken(card, subscription.handleStripeResponse)
#  
#  handleStripeResponse: (status, response) ->
#    if status == 200
#      alert(response.card.last4)
#      console.log(response)
#      $('#stripe_card_token').val(response.id)
#      $('#last4').val(response.card.last4)
#      #$('#payment-form')[0].submit()
#      $.ajax 'update_credit_card',
#        type: 'post',
#        data: {'card_token': response.id, 'last4': response.card.last4 },
#        beforeSend: (jqXHR, settings) ->
#         jqXHR.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
#        success: ->
#          console.log("ajax success")
#        error:   (data, jqXHR, textStatus, errorThrown) -> 
#          console.log(jqXHR)
#          console.log(data)
#
#    else
#      $('#stripe_error').text(response.error.message)
#      $('input[type=submit]').attr('disabled', false)