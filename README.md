# Assignment 1 - Flix

Flix is a movie browsing app.

Submitted by: Juan Luis Herrero Estrada

Time spent: 20 hours spent in total

## User Stories

The following **required** functionality is complete:


* [X]User can view a list of movies currently playing in theaters from The Movie Database (title, poster image, and overview).
* [X]Poster images are loaded using the UIImageView category in the    AFNetworking library.
* [X]The movie poster is available by appending the returned poster_path to https://image.tmdb.org/t/p/w342.
* [X]User sees a loading state while waiting for the movies API (you can use any 3rd party library available to do this).
* [X]User can pull to refresh the movie list.


The following **additional** features are implemented:

* [ ]User sees an error message when there's a networking error. You may not use UIAlertController or a 3rd party library to display the error.
* [ ]Movies are displayed using a CollectionView instead of a TableView.
* [X]User can search for a movie
* [ ]All images fade in as they are loading. 
* [X]User can view the large movie poster by tapping on a cell.
* [ ]For the large poster, load the low resolution image first and then switch to the high resolution image when complete. 
* [ ]Customize the selection effect of the cell.
* [X]Customize the navigation bar.
* [X]Customize the UI. You can use Iconmonstr and The Noun Project as good sources of images.


## Video Walkthrough

Here's a walkthrough of implemented user stories:

GIF created with [LiceCap](http://www.cockos.com/licecap/).

http://i.imgur.com/2oA45ry.mp4

## Notes

Describe any challenges encountered while building the app.
* complicated workspace and maintaining constant work flow.
* adding a functional search bar
* migrating from table view to collection view.

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library


## License

Copyright [yyyy] [name of copyright owner]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
