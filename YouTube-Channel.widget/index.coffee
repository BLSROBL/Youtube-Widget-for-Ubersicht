# Ubersicht Youtube widget
# Change Api key and channel id

API_KEY = "AIzaSyAKExc48wF6FQWe61f009cpm6W3UrxgfBQ"
CHANNEL_ID = "UCTkBppIqrnKa9X7aP4oydkw"

#change this if you want move widget
POSITION_H = "right: 20px"
POSITION_V = "bottom: 70px"

{

command: "curl -s \"https://www.googleapis.com/youtube/v3/channels?part=snippet,statistics&id=#{CHANNEL_ID}&key=#{API_KEY}\""

refreshFrequency: 3600000 # every hour

render: -> """
		<div class="subscribers">
			<span class="num"> </span>
			<span class="label">subscribers</span>
		</div>
		<div class="stats">
			<div class="name-row">
				<div class="icon">
					<svg viewBox="0 0 100 70" xmlns="http://www.w3.org/2000/svg">
						<g transform="translate(0,70) scale(0.1,-0.1)">
							<path fill="#E2231A" d="M194 692 c-140 -11 -167 -38 -186 -190 -12 -96 -5 -325 12 -383 6 -20 19 -48 31 -63 36 -46 75 -51 459 -51 335 0 357 1 394 20 55 28 74 59 87 145 14 92 6 370 -11 420 -35 96 -54 101 -404 105 -160 2 -332 0 -382 -3z"/>
							<path fill="#FFFFFF" d="M653 370 c26 0 -9 -23 -123 -81 l-130 -66 0 137 0 137 123 -63 c67 -35 125 -64 130 -64z"/>
						</g>
					</svg>
				</div>
				<a href="https://www.youtube.com/channel/#{CHANNEL_ID}" class="name"></a>
			</div>
			<span class="views"> </span>
			<span class="uploads"> </span>
		</div>
"""

style: """
	position: fixed
	#{POSITION_H}
	#{POSITION_V}
	width: 290px
	height: 55px
	font-family: Helvetica Neue
	font-size: 13px
	color: #FFF
	padding:15px 0px
	border-radius: 6px
	background-color: rgba(0,0,0,0.55)
	display: flex

	.subscribers
		width: 100px
		text-align:right
		padding-right: 10px
		padding-top: 5px
		border-right: solid 1px rgba(255,255,255,0.2)

		.num
			display: block
			font-size:26px
			line-height:24px

		.label
			display: block
			color:#FFF
			font-size:12px

	.stats
		padding-left: 14px
		color:#FFF
		font-size: 13px
		line-height: 1.5em

		.name-row
			display: flex
			align-items: center
			margin-bottom: 2px

		.views, .uploads
			display: block

	.icon
		width: 18px
		height: 12px
		margin-right: 6px
		opacity:0.9
		svg
			width: 100%
			height: 100%
			display: block

	.error
		color: red
		font-size: 12px
		padding: 0 10px

	a.name
		text-decoration: none
		color: #FFF
		opacity: 1
		font-weight: bold

	a.name:hover
		color:red
"""

# Number formatter: 1234567 -> "1.2M", 12345 -> "12.3K"
formatNumber: (n) ->
	num = parseInt(n, 10)
	return n if isNaN(num)
	if num >= 1000000
		return (num / 1000000).toFixed(1).replace(/\.0$/, '') + 'M'
	else if num >= 1000
		return (num / 1000).toFixed(1).replace(/\.0$/, '') + 'K'
	else
		return num.toLocaleString()

update: (output, domEl) ->

	m = @

	try
		data = JSON.parse(output)
	catch e
		return $(domEl).html("<b class=\"error\">YouTube Widget</b>: bad response (" + e + ")")

	if data.error
		return $(domEl).html("<b class=\"error\">YouTube API Error</b><br>" + data.error.message)

	if !data.items or data.items.length is 0
		return $(domEl).html("<b class=\"error\">YouTube Widget</b>: channel not found")

	channel = data.items[0]
	stats = channel.statistics
	snippet = channel.snippet

	$(domEl).find('.subscribers .num').html @formatNumber(stats.subscriberCount)
	$(domEl).find('.views').html @formatNumber(stats.viewCount) + ' views'
	$(domEl).find('.uploads').html @formatNumber(stats.videoCount) + ' videos'
	$(domEl).find('.name').attr 'href', 'https://www.youtube.com/channel/' + channel.id
	$(domEl).find('.name').html snippet.title

}
