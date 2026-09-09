# YouTube Widget for Übersicht

## Installation

Place the widget in your **Übersicht Widgets folder**, and place the **`ubersicht-youtube` command-line utility** wherever you prefer.

A **YouTube API Key** is required to use this widget. You can get one from the [Google Developer Console](https://console.developers.google.com).

## Configure API Key and Channel ID

Open the widget script and change the **absolute path to the `ubersicht-youtube` command**.

Then enter your YouTube API key and channel ID:

```text
API_KEY = "YOUR API KEY"
CHANNEL_ID = "YOUR CHANNEL ID"
```

### How to find your Channel ID

Go to the YouTube channel you want to use and copy its channel URL.

For example:

```text
https://www.youtube.com/channel/UCTkBppIqrnKa9X7aP4oydkw
```

The part after `/channel/` is the **Channel ID**:

```text
UCTkBppIqrnKa9X7aP4oydkw
```

Get Idea from https://github.com/atika/Ubersicht-Youtube
