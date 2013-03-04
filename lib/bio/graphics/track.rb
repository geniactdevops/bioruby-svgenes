module Bio
  class Graphics
  #The Track class holds and organises the features, ordering them into different rows if they overlap

class Track
  attr_reader :glyph, :name, :label, :args, :track_height, :scale, :max_y, :min_width
  attr_accessor :features, :feature_rows, :name, :number_rows, :feature_height
  #Creates a new Track
  def initialize(args)
    @args = {:glyph => :generic, 
             :name => "feature_track", 
             :label => true, 
             :feature_height => 10,
             :track_height => nil }.merge!(args)
    @glyph = @args[:glyph]
    @name = @args[:name]
    @label = @args[:label]
    @track_height = @args[:track_height]
    @features = []
    @feature_rows = []
    @scale = @args[:scale]
    @feature_height = @args[:feature_height]
    @number_of_rows = 1
    @max_y = args[:max_y]
    @min_width = args[:min_width]
    

  end
  
  #Adds a new MiniFeature to the the @features array
  def add(feature)
    @features << feature
  end

  #Calculates how many rows are needed per track for overlapping features
  #and which row each feature should be in

  def get_rows
    current_row = 1
    @feature_rows = Array.new(@features.length,1)
    @features.each_with_index  do |f1, i|
      @features.each_with_index do |f2, j|
        next if i == j or j <= i
        if overlaps(f1,f2)
          @feature_rows[i] += 1
        end
      end
      @number_rows = @feature_rows.max
    end
  end

  #Calculates if two MiniFeature objects overlap by examining their start and end positions.
  #If two features overlap then then will be placed on separate rows of the track
  #
  #+args+
  #* f1 - a MiniFeature object
  #* f2 - a MiniFeature object
  def overlaps(f1, f2)
    (f1.start >= f2.start and f1.start <= f2.end) or (f1.end >= f2.start and f1.end <= f2.end)
  end
  
end


end
end