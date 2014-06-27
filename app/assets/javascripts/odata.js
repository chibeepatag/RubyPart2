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
	$("#prodIdForm").submit();
	
	var productID = getProductId();
	$.get("/odata/orderID",  {"productID":productID});					
}

function getCustomers(){
	var productID = getProductId();
	if(productID>0){
		$.ajax({
			url: "/odata/customerContact",
			data: {"productID":productID},
			type: "GET",
			accepts: "html",
			success: displayResult
		});
	}else{
		$("#result").html("<span class=\"error\">You must enter a valid product id.</span>");
	}
}

function getProductId(){
	return $("#productID").val();
}

 function displayResult(data){	
	$("#result").html(data);
}
