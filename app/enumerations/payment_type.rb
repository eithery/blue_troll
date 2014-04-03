class PaymentType < EnumerateIt::Base
  associate_values paypal: 0, check: 1, cash: 2, other: 8
end
