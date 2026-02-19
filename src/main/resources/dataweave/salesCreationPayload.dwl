%dw 2.0
output application/json
var sales = vars.requestPayload default {}
---
{
    transactionId: sales.transactionId,
    source: Mule::p("source"),
    customerName: sales.customer_information.name,
    deliveryAddress: sales.customer_information.address,
    customerContact: sales.customer_information.phone,
    customerAge: sales.customer_information.age,
    customerGender: sales.customer_information.gender default null,
    items: sales.line_items map {
		itemId: $.lineId,
		name: $.product,
		price: $.unitPrice,
		quantity: $.quantity
	},
    totalAmount: sales.total,
    paymentType: sales.mop,
    transactionDate: sales.timestamp as DateTime
}