# STIX-XML-Parser

A Ruby-based STIX XML parser that extracts and categorizes Indicators, Observables, Threat Actors, and Campaigns from STIX files. This project uses Nokogiri for XML parsing and Tk for a file selection dialog.

## Features

- Parse STIX XML files
- Extract and categorize Indicators, Observables, Threat Actors, and Campaigns
- Display extracted information in a readable format
- User-friendly file selection dialog using Tk

## Prerequisites

Make sure you have the following installed on your system:

- Ruby
- Bundler (optional but recommended)

## Installation

1. Clone the repository:

    ```sh
    git clone https://github.com/yourusername/STIX-XML-Parser.git
    cd STIX-XML-Parser
    ```

2. Install the required gems:

    ```sh
    bundle install
    ```

    If you are not using Bundler, you can manually install the required gems:

    ```sh
    gem install nokogiri
    gem install tk
    ```

## Usage

1. Run the script:

    ```sh
    ruby stix_parser.rb
    ```

2. A file dialog will appear. Select the STIX XML file you want to parse.

3. The script will output the parsed and categorized information to the console.

## Example Output

