class ApiController < ApplicationController
    protect_from_forgery with: :null_session

    def address
        @loc = AddressLocation.find_by_address(params[:address])
        @loc ||= AddressLocation.create(address: params[:address])
        if @loc.latitude.nil? || @loc.longitude.nil?
            render json: {error: "empty_coordinates"} and return
        end
        if @loc.locator.nil?
            @loc.locator = Rlqth::Utils.locator_from_dimensions(@loc.latitude, @loc.longitude)[0..5]
            @loc.save!
        end
        render json: @loc
    end

    def ip
        @loc = IpLocation.find_by_ip(params[:ip])
        @loc ||= IpLocation.create(ip: params[:ip])
        if @loc.latitude.nil? || @loc.longitude.nil?
            render json: {error: "empty_coordinates"} and return
        end
        if @loc.locator.nil?
            @loc.locator = Rlqth::Utils.locator_from_dimensions(@loc.latitude, @loc.longitude)[0..5]
            @loc.save!
        end
        render json: @loc
    end

    def pure
        @loc = PureLocation.where(latitude: params[:latitude], longitude: params[:longitude]).first
        @loc ||= PureLocation.create(latitude: params[:latitude], longitude: params[:longitude])
        if @loc.latitude.nil? || @loc.longitude.nil?
            render json: {error: "empty_coordinates"} and return
        end
        if @loc.locator.nil?
            @loc.locator = Rlqth::Utils.locator_from_dimensions(@loc.latitude, @loc.longitude)[0..5]
            @loc.save!
        end
        render json: @loc
    end
end
