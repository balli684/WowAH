$api = "https://eu.api.blizzard.com/"
$TokenPage = 'https://eu.battle.net/oauth/token'
$AuthPage = 'https://eu.battle.net/oauth/authorize'
$ClientId = '8280442dd8d5489091ce1923ccaa3fea'
$ClientSecret = 'b4s4WddQP5w3IbKH2qM3WzGvmCUyMbU5'
$realm = 'blades-edge'
$locale = 'en_GB'

$token = Invoke-RestMethod -Uri $TokenPage -Method Post -Body @{client_id=$ClientId;client_secret=$ClientSecret;grant_type="client_credentials"} -ErrorAction STOP

$itemclasses = Invoke-RestMethod -Uri "https://eu.api.blizzard.com/data/wow/item-class/index?namespace=static-eu&locale=en_GB" -Method Get -Headers @{"Authorization" = "Bearer  $($token.access_token)"}
$auctionfile = Invoke-RestMethod -Uri "https://eu.api.blizzard.com/wow/auction/data/$($realm)?locale=$($locale)" -Method Get -Headers @{"Authorization" = "Bearer  $($token.access_token)"}
$auctions = Invoke-RestMethod -Uri $auctionfile.files.url
$petauctions = $auctions.auctions | where {$_.petspeciesid}