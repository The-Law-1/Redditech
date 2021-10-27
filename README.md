
# Redditech

<p align="center">
<a href="https://github.com/The-Law-1/B-DEV-501-NAN-5-1-redditech-gabriel.griffin/actions/workflows/build.yml"><img src="https://github.com/The-Law-1/B-DEV-501-NAN-5-1-redditech-gabriel.griffin/actions/workflows/build.yml/badge.svg" alt="APK build"></a>
<a href="https://github.com/The-Law-1/B-DEV-501-NAN-5-1-redditech-gabriel.griffin/actions/workflows/documentation.yml"><img src="https://github.com/The-Law-1/B-DEV-501-NAN-5-1-redditech-gabriel.griffin/actions/workflows/documentation.yml/badge.svg" alt="Documentation"></a>
<a href="https://github.com/The-Law-1/B-DEV-501-NAN-5-1-redditech-gabriel.griffin/actions/workflows/mirror.yml"><img src="https://github.com/The-Law-1/B-DEV-501-NAN-5-1-redditech-gabriel.griffin/actions/workflows/mirror.yml/badge.svg" alt="Epitech mirror"></a>
</p>

A small Flutter app emulating Reddit's basic functionalities. 

This readme will serve as a functional documentation.

## Home page
![HomePage](https://user-images.githubusercontent.com/62939585/139080611-1e097155-c234-43ef-ad09-a52dafc8e539.png)

The default Home page. This page shows the 25 first posts on the Reddit homepage (can be filtered by New, Hot, and Best).

## Filter wheel

![filter wheel](https://user-images.githubusercontent.com/62939585/139081639-2d1e5e02-7b11-46b9-80ac-3e2ba640e5e7.png)

This floating button can be found on the home page, and on the subreddit page.
Click on the fire icon to filter the posts by "Hot", the heart icon to filter by "Best", and the lightning icon to filter by "New".

## Search page

![search page](https://user-images.githubusercontent.com/62939585/139081664-f69b61eb-ae97-41b0-b694-46325279db48.png)

Click and type your query into the search bar, and the app will show a list of corresponding subreddits.
The user can then click on one of the rows to expand the subreddit and show the page containing the corresponding details and posts.
If the user is connected and is subscribed to one of the subreddits, a heart will show on the row. It can be clicked to unsubscribe from the subreddit.

![hearted sub](https://user-images.githubusercontent.com/62939585/139082766-272cf7aa-1fe8-4c6c-a384-a5763488f2c9.png)

## Subreddit page

![subredditPage](https://user-images.githubusercontent.com/62939585/139081737-ed11e86a-82ee-472c-a928-6626b6d4532f.png)

This page is shown if you click on a subreddit from the search or profile page. It shows the subreddit's banner, picture, title, description, and subscribers. The heart icon is click-able to subscribe/unsubscribe from the subreddit.
Below, you will find a list of the subreddit's latest posts. The filter wheel can be used to filter the posts.

## Settings page

![settingsPage](https://user-images.githubusercontent.com/62939585/139081691-6203e572-b9df-4628-bce2-62828d6db2e1.png)

If the user is connected, the settings page will show 6 toggle widgets. The user can modify their settings from this page.

## Profile page

If the user is not connected, and tries to access the profile page, they will be prompted to connect their account.
![not connected](https://user-images.githubusercontent.com/62939585/139083623-b2b1ad84-d937-4cbc-8669-8ba10cb9ffb2.png)

Once the user is connected, the profile page will show their profile picture, banner, username, and description.
Below, the user can browse the subreddits they are subscribed to, and expand them.
If the heart icon is clicked, the user will be unsubscribed from the corresponding subreddit and it will disappear from the list.

![ProfilePage](https://user-images.githubusercontent.com/62939585/139081713-9945cbbc-85c6-453d-b706-f7c4339e80a2.png)
