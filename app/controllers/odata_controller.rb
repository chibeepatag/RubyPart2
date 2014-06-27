class OdataController < ApplicationController
  def supplier	
	#This makes the product id available to the view.
	@productID = params[:productID].to_i
	#This retrieves the product id from the request parameter.
	productId = params[:productID].to_i

	#This includes the source code to make http requests
	require 'net/http'
	#This includes the source code to parse JSON responses to ruby objects
	require 'json'

	#This is the url to fetch the Product given the entered product ID
	url = "http://services.odata.org/Northwind/Northwind.svc/Products(#{productId})?$format=json"
	#This sends an HTTP get request to fetch the Product
	jsonStr = Net::HTTP.get_response(URI.parse(url))

	#Assigns the body attribute of jsonStr to the variable data
	data = jsonStr.body
	#This parses data into a ruby object
	jsonHash = JSON.parse(data)


	#This prints the product name
	@productName = jsonHash["ProductName"]
	#This prints the supplier id
	@supplierID = jsonHash["SupplierID"]

	#This determines if the product is discontinued and prints the label accordingly
	if (jsonHash["Discontinued"]) 
		  @isdiscontinued = jsonHash["ProductName"].to_s + " is a discontinued product"
	   else 
		  @isdiscontinued = jsonHash["ProductName"].to_s + " is an active product"   
	end

	#This is the url to fetch the supplier given the supplier id
	supplierURL = "http://services.odata.org/Northwind/Northwind.svc/Suppliers(#{jsonHash["SupplierID"]})?$format=json"
	#This sends an HTTP request to fetch the supplier
	supplierStr = Net::HTTP.get_response(URI.parse(supplierURL))
	supplierData = supplierStr.body
	#This parses the body of the http JSON response to a ruby object
	supplierHash = JSON.parse(supplierData)
	#This prints the supplier name
	@companyName = supplierHash["CompanyName"]
	
	#return only the html snippet for ajax response. No need for full html
	render(:layout => false) if request.xhr?		
	end

  def orderID
	#This makes the product id available to the view.
	@productId = params[:productID].to_i
	#This retrieves the product id from the request parameter.
	productId = params[:productID].to_i
	
	#This includes the source code to make http requests
	require 'net/http'
	#This includes the source code to parse JSON responses to ruby objects
	require 'json'
	#This is the url to get the number of order details of the given product
	url = "http://services.odata.org/Northwind/Northwind.svc/Order_Details/$count?$filter=ProductID%20eq%20#{productId}"
	#This sends the http get request for the order details
	response = Net::HTTP.get_response(URI.parse(url))
	#This gets the body of the response received which is the count of orders
	@noOfOrders = response.body
	
	#This is the url to get the order details of the given product id
	ordersUrl = "http://services.odata.org/Northwind/Northwind.svc/Products(#{productId})/Order_Details?$format=json"
	#This sends the get request to fetch the order details
	ordersResponse = Net::HTTP.get_response(URI.parse(ordersUrl))

	data = ordersResponse.body
	#This parses the response body from json to a ruby object.
	ordersHash = JSON.parse(data)
	#This makes the object ordersHash available to the view.
	@ordersHash = ordersHash			
	#return only the html snippet for ajax response. No need for full html
	render(:layout => false) if request.xhr?	
  end

  def customerContact
    #This makes the product id available to the view.
	productID = params[:productID].to_i
	#This retrieves the product id from the request parameter.
	@productID = productID
	
	#This is the url to fetch the number of order details for the entered product
	countUrl = "http://services.odata.org/Northwind/Northwind.svc/Products(#{productID})/Order_Details/$count"
	#This includes the source code to make http requests
	require 'net/http'
	#This includes the source code to parse JSON responses to ruby objects
	require 'json'
	#This sends the http get request for the order detail count
	count = Net::HTTP.get_response(URI.parse(countUrl)).body
	#This makes the variable count available to the view
	@count = count
	
	#This is the url to fetch the order details given the product id
	orderDetailsUrl = "http://services.odata.org/Northwind/Northwind.svc/Products(#{productID})/Order_Details?$format=json"
	#This sends the http get request for the order details
	orderDetail = Net::HTTP.get_response(URI.parse(orderDetailsUrl)).body
	#This parses the response into a ruby object
	orderDetailHash = JSON.parse(orderDetail)
	#This makes the object ordersHash available to the view.
	@orderDetailHash = orderDetailHash	
	#return only the html snippet for ajax response. No need for full html
	render(:layout => false) if request.xhr?	
  end
  
end
