dhtPin = 3
dhtPin2 = 2

wifi.sta.sethostname("uopNodeMCU")
wifi.setmode(wifi.STATION)
station_cfg={}
station_cfg.ssid="Wifi Name" 
station_cfg.pwd="Password"
station_cfg.save=true
wifi.sta.config(station_cfg)
wifi.sta.connect()

mytimer = tmr.create()
mytimer:register(3000, 1, function() 
   if wifi.sta.getip()==nil then
        --print("Connecting to AP...\n")
   else
        ip, nm, gw=wifi.sta.getip()
        mac = wifi.sta.getmac()
        rssi = wifi.sta.getrssi()
        ----print("IP Info: \nIP Address: ",ip)
        --print("Netmask: ",nm)
        --print("Gateway Addr: ",gw)
        --print("MAC: ",mac)  
        --print("RSSI: ",rssi,"\n")
        mytimer:stop()
   end 
end)
mytimer:start()

if not tmr.create():alarm(5000, tmr.ALARM_AUTO, function()
status, temp1, humi1, temp_dec, humi_dec = dht.read11(dhtPin)

if status == dht.OK then
    --print("DHT Temperature:"..temp..";".."Humidity:"..humi)
-- 2 dots are used for concatenation

elseif status == dht.ERROR_CHECKSUM then
   -- print( "DHT Checksum error." )
elseif status == dht.ERROR_TIMEOUT then
    --print( "DHT timed out." )
end
  --print("Temperature and Humidity Given")
end)
then
 -- print("Whoops")
end

if not tmr.create():alarm(5000, tmr.ALARM_AUTO, function()
status, temp2, humi2, temp_dec, humi_dec = dht.read11(dhtPin2)

if status == dht.OK then
    print(temp1..","..temp2..","..humi1..","..humi2.."\n")
-- 2 dots are used for concatenation

elseif status == dht.ERROR_CHECKSUM then
    --print( "DHT Checksum error." )
elseif status == dht.ERROR_TIMEOUT then
    --print( "DHT timed out." )
end
  --print("Temperature and Humidity Given")
end)
then
  --print("Whoops")
end
