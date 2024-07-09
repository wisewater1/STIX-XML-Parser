require 'rubygems'
require 'nokogiri'
require 'tk'

class StixParser
  NAMESPACES = {
    'stix' => 'http://stix.mitre.org/stix-1',
    'cybox' => 'http://cybox.mitre.org/cybox-2'
  }.freeze

  def initialize(file_path)
    @file_path = file_path
    @indicators = []
    @observables = []
    @threat_actors = []
    @campaigns = []
  end

  def parse
    doc = load_xml
    return unless doc

    namespaces = doc.collect_namespaces
    namespaces = NAMESPACES if namespaces.empty?

    categorize_items(doc, namespaces)
    print_items
  end

  private

  def load_xml
    Nokogiri::XML(File.open(@file_path))
  rescue StandardError => e
    puts "Error reading the XML file: #{e.message}"
    nil
  end

  def categorize_items(doc, namespaces)
    extract_items(doc, '//stix:Indicator', namespaces, @indicators, 'stix')
    extract_items(doc, '//cybox:Observable', namespaces, @observables, 'cybox')
    extract_items(doc, '//stix:ThreatActor', namespaces, @threat_actors, 'stix')
    extract_items(doc, '//stix:Campaign', namespaces, @campaigns, 'stix')
  rescue StandardError => e
    puts "Error parsing the XML file: #{e.message}"
  end

  def extract_items(doc, xpath, namespaces, collection, prefix)
    doc.xpath(xpath, namespaces).each do |node|
      collection << {
        id: node['id'],
        title: node.at_xpath("#{prefix}:Title", namespaces)&.text,
        description: node.at_xpath("#{prefix}:Description", namespaces)&.text
      }
    end
  end

  def print_items
    print_category('Indicators', @indicators)
    print_category('Observables', @observables)
    print_category('Threat Actors', @threat_actors)
    print_category('Campaigns', @campaigns)
  end

  def print_category(name, items)
    puts "#{name}:"
    items.each { |item| puts item }
    puts
  end
end

def get_file_path
  root = TkRoot.new
  root.withdraw # Hide the root window
  file_path = Tk.getOpenFile
  root.destroy # Destroy the root window after file selection
  file_path
end

# Ask the user for the path to the STIX XML file using file dialog
puts 'Please select the STIX XML file:'
stix_file_path = get_file_path

# Check if a file was selected
if stix_file_path.nil? || stix_file_path.empty?
  puts 'No file selected. Exiting.'
  exit
end

# Parse the STIX XML file
parser = StixParser.new(stix_file_path)
parser.parse
