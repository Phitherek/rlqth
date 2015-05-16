class MainController < ApplicationController
    def index
    end

    def address
        @loc = AddressLocation.new
    end

    def address_locator
        @loc = AddressLocation.find_by_address(params[:address_location][:address])
        @loc ||= AddressLocation.create(params.require(:address_location).permit(:address))
        if @loc.locator.nil?
            @loc.locator = Rlqth::Utils.locator_from_dimensions(@loc.latitude, @loc.longitude)
            @loc.save!
        end
        render :result
    end

    def ip
        @loc = IpLocation.new
    end

    def ip_locator
        @loc = IpLocation.find_by_ip(params[:ip_location][:ip])
        @loc ||= IpLocation.create(params.require(:ip_location).permit(:ip))
        if @loc.locator.nil?
            @loc.locator = Rlqth::Utils.locator_from_dimensions(@loc.latitude, @loc.longitude)
            @loc.save!
        end
        render :result
    end

    def pure
        @loc = PureLocation.new
    end

    def pure_locator
        @loc = PureLocation.where(latitude: params[:pure_location][:latitude], longitude: params[:pure_location][:longitude]).first
        @loc ||= PureLocation.create(params.require(:pure_location).permit(:latitude, :longitude))
        if @loc.locator.nil?
            @loc.locator = Rlqth::Utils.locator_from_dimensions(@loc.latitude, @loc.longitude)
            @loc.save!
        end
        render :result
    end

    def geolocate
    end
end
