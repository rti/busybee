## Example taxonomy: movie website

Let's assume you are making a website about movies. You may want to include the following taxonomies:

- Actors
- Directors
- Studios
- Genre
- Year
- Awards

Then, in each of the movies, you would specify terms for each of these taxonomies (i.e., in the front matter of each of your movie content files). From these terms, Hugo would automatically create pages for each Actor, Director, Studio, Genre, Year, and Award, with each listing all of the Movies that matched that specific Actor, Director, Studio, Genre, Year, and Award.

### Movie taxonomy organization

To continue with the example of a movie site, the following demonstrates content relationships from the perspective of the taxonomy:

```txt
Actor                    <- Taxonomy
    Bruce Willis         <- Term
        The Sixth Sense  <- Value
        Unbreakable      <- Value
        Moonrise Kingdom <- Value
    Samuel L. Jackson    <- Term
        Unbreakable      <- Value
        The Avengers     <- Value
        xXx              <- Value
```

From the perspective of the content, the relationships would appear differently, although the data and labels used are the same:

```txt
Unbreakable                 <- Value
    Actors                  <- Taxonomy
        Bruce Willis        <- Term
        Samuel L. Jackson   <- Term
    Director                <- Taxonomy
        M. Night Shyamalan  <- Term
    ...
Moonrise Kingdom            <- Value
    Actors                  <- Taxonomy
        Bruce Willis        <- Term
        Bill Murray         <- Term
    Director                <- Taxonomy
        Wes Anderson        <- Term
    ...
```

### Default destinations

When taxonomies are used Hugo will automatically create both a page listing all the taxonomy's terms and individual pages with lists of content associated with each term. For example, a `categories` taxonomy declared in your configuration and used in your content front matter will create the following pages:

- A single page at `example.com/categories/` that lists all the terms within the taxonomy
- Individual taxonomy list pages (e.g., `/categories/development/`) for each of the terms that shows a listing of all pages marked as part of that taxonomy within any content file's front matter

