module TimelinesHelper

  def add_place_link(name)
    link_to_function name do |page|
      page.insert_html :bottom, :places, :partial => 'place', :object => Place.new
    end
  end

end
