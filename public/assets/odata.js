$(document).ready(function(){
	$("#supplier").click(getSupplier);
	$("#orders").click(getOrders);
	$("#customers").click(getCustomers);
});
var i = 0;
function getSupplier(){
	var productID = getProductId();
	console.log(i++);
	$.ajax({
		url: "/odata/supplier",
		data: {"productID":productID},
		type: "GET",
		accepts: "html",
		success: displayResult
	});
}

function getOrders(){
	var productID = getProductId();
}

function getCustomers(){
	var productID = getProductId();
}

function getProductId(){
	return $("#productID").val();
}
var j = 0;
 function displayResult(data){
	console.log(j++);
	console.log(data);
	$("#result").append(data);
}