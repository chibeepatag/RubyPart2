$(document).ready(function(){
	$("#supplier").click(getSupplier);
	$("#orders").click(getOrders);
	$("#customers").click(getCustomers);
});

function getSupplier(){
	var productID = getProductId();
	
	if(productID>0){
		$.ajax({
			url: "/odata/supplier",
			data: {"productID":productID},
			type: "GET",
			accepts: "html",
			success: displayResult
		});
	}else{
		$("#result").html("<span class=\"error\">You must enter a valid product id.</span>");
	}
	
}

function getOrders(){
	var productID = getProductId();
	$.ajax({
		url: "/odata/orderID",
		data: {"productID":productID},
		type: "GET",
		accepts: "html",
		success: displayResult
	});
}

function getCustomers(){
	var productID = getProductId();
		$.ajax({
		url: "/odata/customerContact",
		data: {"productID":productID},
		type: "GET",
		accepts: "html",
		success: displayResult
	});
}

function getProductId(){
	return $("#productID").val();
}

 function displayResult(data){	
	$("#result").html(data);
}