require 'rspec'
require 'watir'

describe 'Smoke Test Cases: ' do
    before :all do
        @browser = Watir::Browser.new :firefox
        @browser.window.maximize
        @browser.goto('http://www.automationpractice.com/index.php')
    end

    after :all do
        @browser.close
    end

    context '1. Login with valid credentials' do

        it "clicks on Sign in button" do
            @browser.a(class: 'login').click
        end

        it "enters valid username and password" do
            @browser.input(id: 'email').set 'adnanabesic@gmail.com'
            @browser.input(id: 'passwd').set 'DoTask123!'
        end

        it "clicks on Sign in button" do
            @browser.button(id: 'SubmitLogin').click
            sleep 5
        end   

        it "verify is user logged in" do
            expect(@browser.h1(class: 'page-heading').text).to eql('MY ACCOUNT')
        end
    end

    context '2. Verify the Search option using a product/brand/category name' do
        
        it "navigates to home page" do
            @browser.img(class: 'logo img-responsive').click
        end

        it "navigates to the search box and writes 'Blouse' in the search bar" do
            @browser.input(id: 'search_query_top').set 'Blouse'
        end

        it "clicks Search button" do
            @browser.button(name: 'submit_search').click
        end

        it "checks searched product is found" do
            expect(@browser.span(class: 'lighter').text).to eql("\"BLOUSE\"")
        end
    end

    context '3. Select Item and Add to Cart' do

        it "clicks on searched item" do
            @browser.img(title: 'Blouse').click
        end 

        it "select quantity" do
            @browser.a(class: 'btn btn-default button-plus product_quantity_up').click
        end

        it "select size M" do
            @browser.select(id: 'group_1').option(value: '2').value #=> '2'  
        end

        it "select color black" do
            @browser.a(name: 'Black').click
        end

        it "click on Add to Cart button" do
            @browser.button(name: 'Submit').click
            sleep 3
        end

        it "verify product is added to cart" do
            expect(@browser.h2.text).to eql('Product successfully added to your shopping cart')
        end
    end

    context '4. Verify the Procced to checkout functionality and Pay by bank wire button' do

        it "click on procced to checkout button" do
            @browser.a(class: 'btn btn-default button button-medium').click
        end

        it "click on procced to checkout button" do
            @browser.a(class: 'button btn btn-default standard-checkout button-medium').click
        end

        it "click on procced to checkout button" do
            @browser.button(class: 'button btn btn-default button-medium').click
        end

        it "select 'I agree to the terms of service and will adhere to them unconditionally' checkbox" do
            @browser.input(id: 'cgv').click
        end

        it "click on Proceed to checkout button" do
            @browser.button(name: 'processCarrier').click
        end

        it "click on Pay by bank wire button" do
            @browser.a(class: 'bankwire').click
        end

        it "click on I confirm my order button" do
            @browser.button(class: 'button btn btn-default button-medium').click
            sleep 5
        end

        it "shows 'Order confirmation.' pop-up message" do
            expect(@browser.h1(class: 'page-heading').text).to eql('ORDER CONFIRMATION')
        end
    end
end
