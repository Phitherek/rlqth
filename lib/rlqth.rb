module Rlqth
    class Utils
        def self.locator_from_dimensions(latitude, longitude)
            latitude = latitude + 90
            longitude = longitude + 180
            lat = latitude.to_s
            lat_deg = lat.split(".").first.to_i
            lat_min = lat.split(".").second
            lat_min = "0." + lat_min
            lat_min = lat_min.to_f
            lat_min = lat_min*60
            lon = longitude.to_s
            lon_deg = lon.split(".").first.to_i
            lon_min = lon.split(".").second
            lon_min = "0." + lon_min
            lon_min = lon_min.to_f
            lon_min = lon_min*60
            k = 12*(longitude-2*(longitude/2).floor)
            l = 24*(latitude - latitude.floor)
            loc1 = (lon_deg/20).floor
            lon_tmp = lon_deg - loc1*20
            loc1 = (65+loc1).chr
            loc2 = (lat_deg/10).floor
            lat_tmp = lat_deg - loc2*10
            loc2 = (65+loc2).chr
            loc3 = lon_tmp/2
            loc4 = lat_tmp
            loc5 = (97+k.floor).chr
            loc6 = (97+l.floor).chr
            loc7 = 10*(k-k.floor).floor
            loc8 = 10*(l-l.floor).floor
            loc = loc1 + loc2 + loc3.to_s + loc4.to_s + loc5 + loc6 + loc7.to_s + loc8.to_s
        end

        def self.dimensions_from_locator(locator)
            loc1 = locator[0].upcase
            loc2 = locator[1].upcase
            loc3 = locator[2]
            loc4 = locator[3]
            loc5 = locator[4].downcase
            loc6 = locator[5].downcase
            loc7 = locator[6]
            loc8 = locator[7]
            loc1 = loc1.ord if !loc1.nil?
            loc1 = loc1 - 65 if !loc1.nil?
            loc2 = loc2.ord if !loc2.nil?
            loc2 = loc2 - 65 if !loc2.nil?
            loc3 = loc3.to_i if !loc3.nil?
            loc4 = loc4.to_i if !loc4.nil?
            loc5 = loc5.ord if !loc5.nil?
            loc5 = loc5 - 97 if !loc5.nil?
            loc6 = loc6.ord if !loc6.nil?
            loc6 = loc6 - 97 if !loc6.nil?
            loc7 = loc7.to_i if !loc7.nil?
            loc8 = loc8.to_i if !loc8.nil?
            loc1 ||= 0.0
            loc2 ||= 0.0
            loc3 ||= 0.0
            loc4 ||= 0.0
            loc5 ||= 0.0
            loc6 ||= 0.0
            loc7 ||= 0.0
            loc8 ||= 0.0
            latitude = 0.0
            longitude = 0.0
            longitude += loc1*20
            latitude += loc2*10
            longitude += loc3*2
            latitude += loc4
            k = 0.0
            l = 0.0
            k += loc5
            l += loc6
            k += loc7/10
            l += loc8/10
            k = k/12
            l = l/24
            longitude += k
            latitude += l
            latitude = latitude-90
            longitude = longitude-180
            [latitude, longitude]
        end
    end
end