## https://eu.api.blizzard.com/data/wow/item/4305?namespace=static-eu&locale=en_GB&access_token=USu0wJCblCmX5WtHhvBNlSmsrhOXf0dEW9

if (!($ahauctions)) {
    $apiurl = "https://eu.api.blizzard.com/wow/auction/data/blades-edge?access_token=USu0wJCblCmX5WtHhvBNlSmsrhOXf0dEW9"
    $apirequest = Invoke-WebRequest $apiurl
    $ahurl = ($apirequest | ConvertFrom-Json).files.url
    $ahauctions = Invoke-WebRequest $ahurl
    $ahauctions = ($ahauctions.Content | convertfrom-json).auctions
    
}

foreach ($auction in $ahauctions) {
    $apirequest = "https://eu.api.blizzard.com/data/wow/item/$($auction.item)?namespace=static-eu&locale=en_GB&access_token=USu0wJCblCmX5WtHhvBNlSmsrhOXf0dEW9"
    $iteminfo = Invoke-WebRequest $apirequest
    $iteminfo = $iteminfo.Content | ConvertFrom-Json
    $auction | Add-Member -MemberType NoteProperty -Name "itemname" -Value $iteminfo.name
    $auction | Add-Member -MemberType NoteProperty -Name "itemclass" -Value $iteminfo.item_class.id
    $auction | Add-Member -MemberType NoteProperty -Name "vendorprice" -Value $iteminfo.sell_price
}

$ahauctions | convertto-csv | out-file ".\auctions.csv"