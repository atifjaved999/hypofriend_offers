require "hypofriend_offers/version"
require 'net/http'
require 'json'

module HypofriendOffers
  class Error < StandardError; end


  class NewOffers

    BASE_URL = "https://offer-v3.hypofriend.de/api/v5"

    attr_reader :loan_amount, :property_value, :repayment, :years_fixed

    def initialize(args = {})
      @loan_amount = args[:loan_amount]
      @property_value = args[:property_value]
      @repayment = args[:repayment]
      @years_fixed = args[:years_fixed]
    end

    def call
      uri = URI("#{BASE_URL}/new-offers#{query_string}")
      result = Net::HTTP.start(uri.host, uri.port, :use_ssl => true) do |http|
        request = Net::HTTP::Get.new uri
        response = http.request request # Net::HTTPResponse object
      end
      JSON.parse(result.body)
    end

    private

    def query_string
      query = ""
      query = "?loan_amount=#{loan_amount}" unless loan_amount.nil?
      query += "&property_value=#{property_value}" unless property_value.nil?
      query += "&repayment=#{repayment}" unless property_value.nil?
      query += "&years_fixed=#{years_fixed}" unless property_value.nil?
      query
    end
  end
end
