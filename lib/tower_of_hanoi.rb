class TowerOfHanoi

  NUM_DISKS = 3

  attr_accessor :towers

  # Allow a game state to be
  # set on initialize
  def initialize(game_state=nil)
    @towers = game_state || default_state
  end

  # Move a disk from
  # one tower to another
  def move(from, to)
    from, to = @towers[from - 1], @towers[to - 1]
    disk = from.shift
    to.unshift(disk)
  end


  # Returns true when the
  # game state is winning
  def win?
    tower = @towers.last
    win_state = Array.new(NUM_DISKS) { |i| i + 1 }
    tower == win_state
  end


  # Returns true if the move
  # is valid
  def valid_move?(from, to)
    valid_towers?(from, to) &&
    has_disks?(@towers[from - 1]) &&
    can_move?(@towers[from - 1], @towers[to - 1])
  end


  private
  # Create the default
  # beginning game state
  def default_state
    [Array.new(NUM_DISKS) { |i| i + 1 }, [], []]
  end


  # Checks if the tower numbers
  # are valid
  def valid_towers?(from, to)
    [from, to].all? { |tower| [1, 2, 3].include?(tower) }
  end

  # Returns true if the
  # tower has disks
  def has_disks?(tower)
    !tower.empty?
  end

  # Returns true if you
  # can move from the first
  # tower to the second
  def can_move?(from, to)
    to.empty? || from.first < to.first
  end
end



# t = TowerOfHanoi.new
# p t.towers
# p t.towers.each