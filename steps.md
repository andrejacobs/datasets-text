# Steps taken to produce these datasets

The hierarchy of this document roughly mirrors the directories in this repo.

## Corpora

### Gutenberg.org

Sources:

-   Alice in Wonderland: https://www.gutenberg.org/ebooks/11

    -   english: https://www.gutenberg.org/ebooks/11.txt.utf-8
    -   french: https://www.gutenberg.org/ebooks/55456.txt.utf-8
    -   german: https://www.gutenberg.org/ebooks/19778.txt.utf-8
    -   italian: https://www.gutenberg.org/ebooks/28371.txt.utf-8

-   Frankenstein: https://gutenberg.org/ebooks/84

    -   english: https://gutenberg.org/ebooks/84.txt.utf-8
    -   french: https://gutenberg.org/ebooks/62404, https://gutenberg.org/ebooks/62405, https://gutenberg.org/ebooks/62406

-   Dracula: https://www.gutenberg.org/ebooks/345

    -   english: https://www.gutenberg.org/ebooks/345.txt.utf-8

Removed the Gutenberg english header and footer and placed in a file named liked "gutenberg-...txt" for the French, German and Italian versions.

The French version of Frankenstein is split over 3 volumes so removed each of the english headers and footers and then concatenated all 3 files into a single file.

Each of the books were zipped.
