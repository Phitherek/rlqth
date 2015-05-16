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
            loc1 = (lon_deg/20).floor
            lon_tmp = lon_deg - loc1*20
            loc1 = (65+loc1).chr
            loc2 = (lat_deg/10).floor
            lat_tmp = lat_deg - loc2*10
            loc2 = (65+loc2).chr
            loc3 = lon_tmp/2
            loc4 = lat_tmp
            loc5 = (lon_min/2.5).floor
            loc5 = (97+loc5).chr
            loc6 = (lat_min/2.5).floor
            loc6 = (97+loc6).chr
            loc = loc1 + loc2 + loc3.to_s + loc4.to_s + loc5 + loc6
        end
    end
end