# youtube-dlp-subscriptions

Downloads new videos from your YouTube subscription feeds since the last run.


## Requirements

This script requires python3. Additional dependencies can be found in the `requirements.txt` file.

## Usage (Docker-Compose)
If you are familiar with what docker is, and what docker-compose is to docker, this is the recommended method to use.

Create a `subs.xml` file inside `app/` and populate it with your channels to download from. See `subs.sample.xml` for an example. See "More on subs.xml" chapter below for more info.

First time only: `docker build`

Every subsequnt time: `docker run`

A cron job can be set up to run the process at specified intervals. Be sure to `cd` into the directory first before running `docker run` from cron.

sample:
every day at 2AM, log stdout/stderr to log as well
`0 2 * * * cd /home/darkenvy/git/youtube-dlp-subscriptions && docker-compose up 2>&1 | tee log.txt`

## Usage (Manual)

Clone the repository

    `git clone https://github.com/darkenvy/youtube-dlp-subscriptions`
    `cd youtube-dlp-subscriptions/app/`

Install the requirements

    pip install -r requirements.txt

You will need to generate an xml file and name it `subs.xml`. See subs.sample.xml for an example. In the past, this file was easily generated, but Google has removed the feature to generate a OMPL file as a means to stop driving traffic away from youtube (and onto newsreaders and the like).

You can then run the script

    python3 dl.py

A `last.txt` file will be created in order to avoid downloading the same videos on the next run.

## More on subs.xml

Start with this initial template:
```
<opml version="1.1">
  <body>
    <outline text="YouTube Subscriptions" title="YouTube Subscriptions">
      <outline title="ANYTHING" type="rss" xmlUrl="https://www.youtube.com/feeds/videos.xml?channel_id=CHANNEL_ID" />
    </outline>
  </body>
</opml>
```

The ONLY factor that you must change is the string of `CHANNEL_ID`. the text ANYTHING is only for self-comments (and is useful for maintaining a long list ;) ).

## SyncThing
Syncthing can be set up to sync from the downloads folder onto any other device (such as an android). Quite useful for long trips without cellular internet (or a data plan).

## TODO:
Get rid of the XML entirely now that it is no longer a point-of-convenience.
Favor a item list of channel_ids. Perhaps utilize yt-dlp's `-a` flag, which can take a list and download them. `--playlist-end 15` and `--dateafter` are also useful flags.

## Thanks

A thanks to mewfree and https://github.com/mewfree/youtube-dl-subscriptions for the original script and pukkandan for dlp.
