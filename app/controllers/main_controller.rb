class MainController < ApplicationController

    before_filter :find_user
    before_filter :user_only, only: :history

    def address
        @loc = AddressLocation.new
        @main_nav_active = :address
    end

    def address_locator
        @loc = AddressLocation.find_by_address(params[:address_location][:address])
        @loc ||= AddressLocation.create(params.require(:address_location).permit(:address))
        @main_nav_active = :address
        if @loc.latitude.nil? || @loc.longitude.nil?
            flash[:error] = t("errors.empty_coordinates")
            render :address and return
        end
        if @loc.locator.nil?
            @loc.locator = Rlqth::Utils.locator_from_dimensions(@loc.latitude, @loc.longitude)[0..5]
            @loc.save!
        end
        if !@user.nil?
            HistoricalQuery.create(remote_user: @user, location: @loc)
        end
        render :result
    end

    def ip
        @loc = IpLocation.new
        @main_nav_active = :ip
    end

    def ip_locator
        @loc = IpLocation.find_by_ip(params[:ip_location][:ip])
        @loc ||= IpLocation.create(params.require(:ip_location).permit(:ip))
        @main_nav_active = :ip
        if @loc.latitude.nil? || @loc.longitude.nil?
            flash[:error] = t("errors.empty_coordinates")
            render :ip and return
        end
        if @loc.locator.nil?
            @loc.locator = Rlqth::Utils.locator_from_dimensions(@loc.latitude, @loc.longitude)[0..5]
            @loc.save!
        end
        if !@user.nil?
            HistoricalQuery.create(remote_user: @user, location: @loc)
        end
        render :result
    end

    def pure
        @loc = PureLocation.new
        @main_nav_active = :pure
    end

    def pure_locator
        @loc = PureLocation.where(latitude: params[:pure_location][:latitude], longitude: params[:pure_location][:longitude]).first
        @loc ||= PureLocation.create(params.require(:pure_location).permit(:latitude, :longitude))
        @main_nav_active = :pure
        if @loc.latitude.nil? || @loc.longitude.nil?
            flash[:error] = t("errors.empty_coordinates")
            render :pure and return
        end
        if @loc.locator.nil?
            @loc.locator = Rlqth::Utils.locator_from_dimensions(@loc.latitude, @loc.longitude)[0..5]
            @loc.save!
        end
        if !@user.nil?
            HistoricalQuery.create(remote_user: @user, location: @loc)
        end
        render :result
    end

    def reverse
        @loc = ReverseLocation.new
        @main_nav_active = :reverse
    end

    def reverse_query
        @loc = ReverseLocation.where(locator: params[:reverse_location][:locator]).first
        @loc ||= ReverseLocation.create(params.require(:reverse_location).permit(:locator))
        @main_nav_active = :reverse
        if !@user.nil?
            HistoricalQuery.create(remote_user: @user, location: @loc)
        end
        render :reverse_result
    end

    def geolocate
    end

    def history
        @hqs = HistoricalQuery.where(remote_user_id: @user.id).order(updated_at: :desc)
    end

    def omniauth_callback
        if !auth_hash.nil?
            @user = RemoteUser.find_by_callsign(auth_hash.info.callsign)
            if @user.nil?
                @user = RemoteUser.create(callsign: auth_hash.info.callsign, email: auth_hash.info.email)
                @user.reload
            end
            @session = RemoteSession.new
            @session.token = auth_hash.credentials.token
            @session.token_expires = Time.at(auth_hash.credentials.expires_at)
            @session.refresh_token = auth_hash.credentials.refresh_token
            @session.remote_user = @user
            @session.save!
            @user.save!
            session['remote_session_token'] = @session.token
        end
        redirect_to root_path
    end

    def logout
        HTTParty.post("https://rlauth.phitherek.me/oauth/revoke?token=#{@session.token}")
        @session.destroy
        session.delete('remote_session_token')
        redirect_to root_path
    end

    def get_i18n
        render json: {i18n: I18n.t(params[:key], locale: params[:locale] || I18n.default_locale)}
    end

    private

    def auth_hash
        request.env['omniauth.auth']
    end

    def find_user
        if session['remote_session_token'] != nil
            @session = RemoteSession.find_by_token(session['remote_session_token'])
            if !@session.nil?
                @user = @session.remote_user
                @check = JSON.parse(HTTParty.get("https://rlauth.phitherek.me/api/user_data?access_token=#{@session.token}").body || "{}")
                if @check.include?("status") && @check["status"] == "failure"
                    session['remote_session_token'] = nil
                    redirect_to '/auth/rlauth' and return
                elsif @check.include?("user")
                    @user = RemoteUser.find_by_callsign(@check["user"]["callsign"])
                    if !@user.nil?
                        session['remote_session_token'] = @session.token
                    else
                        session['remote_session_token'] = nil
                    end
                end
            else
                @user = nil
            end
        else
            @user = nil
        end
    end

    def user_only
        redirect_to root_path unless !@user.nil?
    end
end
