# datasets-text

Datasets used in text processing.

**NOTE: The MIT `LICENSE` does not cover the files found in the `corpora` directory. See each corpus for specific licensing and terms of use.**

## Collection method

Please see the `steps.md` document for more information on how each corpus was collected and processed.

## Contributing

Thank you for considering contributions, however I am not taking any contributions towards adding new corpus sets.
Simply because I want to keep the size of this repo down to a minimum.

Code contributions are welcome.

## Generating ngrams

If you want to generate your own ngrams then please install `ngrams` from https://github.com/andrejacobs/go-analyse

Run the script `ngrams.sh`:

```shell
./scripts/ngrams.sh
```

At the time of writing the generated ngrams are about 1.98GB.

To package up the ngrams into zip files, run the script `package.sh`:

```shell
./scripts/package.sh
```

At the time of writing the packaged files is about 410MB.

## Disclaimer

Minimum processing was done to the source corpora and thus the generated ngrams will reflect that. For example the top 3 words from the Gutenberg sources include things like "\* \* \*" and "the project gutenberg".

Also for time being the `ngrams` program makes no attempt at stripping symbols or doing any post processing on the input sources.
