require "eaal"

module XmlApi
  class TowerImport

    def initialize
    end

    def execute
      starbases.map do |pos|
        tower = find_or_initialize_tower(pos)
        tower.moon = find_or_create_moon(pos) if tower.moon.nil?

        tower = add_fuel_to(tower)

        tower.save!
      end
    end

    private

    def starbases
      @starbases ||= begin
        pos_list = api.StarbaseList
        #<CorpStarbaseListResult:0x007fdbfd1212c8 @request_time="2015-04-30 02:33:14", @cached_until="2015-04-30 02:50:29", @starbases=[#<CorpStarbaseListRowsetStarbasesRow:0x007fdbfd133e00 @container={}, @attribs={}, @itemID="1017965882526", @typeID="20062", @locationID="30000125", @moonID="40008123", @state="1", @stateTimestamp="2015-04-20 06:46:21", @onlineTimestamp="0001-01-01 00:00:00", @standingOwnerID="98293472">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfd133518 @container={}, @attribs={}, @itemID="1017931622896", @typeID="20062", @locationID="30003810", @moonID="40241241", @state="1", @stateTimestamp="2015-04-14 06:59:10", @onlineTimestamp="0001-01-01 00:00:00", @standingOwnerID="98293472">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfd132938 @container={}, @attribs={}, @itemID="1005692609681", @typeID="20059", @locationID="31000510", @moonID="40377572", @state="4", @stateTimestamp="2015-04-30 02:52:14", @onlineTimestamp="2015-03-18 04:51:48", @standingOwnerID="98293472">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfd131a88 @container={}, @attribs={}, @itemID="1014072219871", @typeID="16214", @locationID="31000510", @moonID="40377602", @state="4", @stateTimestamp="2015-04-30 03:06:51", @onlineTimestamp="2014-10-14 02:03:57", @standingOwnerID="99002824">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfd131128 @container={}, @attribs={}, @itemID="1015109660984", @typeID="20065", @locationID="31000510", @moonID="40377600", @state="4", @stateTimestamp="2015-04-30 02:40:32", @onlineTimestamp="2014-12-02 04:38:23", @standingOwnerID="99002824">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfd130840 @container={}, @attribs={}, @itemID="1015328097656", @typeID="20065", @locationID="31000510", @moonID="40377606", @state="1", @stateTimestamp="2015-04-24 23:24:55", @onlineTimestamp="0001-01-01 00:00:00", @standingOwnerID="99002824">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfd132aa0 @container={}, @attribs={}, @itemID="1016223001815", @typeID="16213", @locationID="31000510", @moonID="40377622", @state="4", @stateTimestamp="2015-04-30 02:47:13", @onlineTimestamp="2014-10-18 16:43:50", @standingOwnerID="98293472">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfd12b638 @container={}, @attribs={}, @itemID="1016235321951", @typeID="16214", @locationID="31000510", @moonID="40377611", @state="4", @stateTimestamp="2015-04-30 03:08:13", @onlineTimestamp="2014-10-20 00:04:18", @standingOwnerID="99002824">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfd12ada0 @container={}, @attribs={}, @itemID="1016243201823", @typeID="20065", @locationID="31000510", @moonID="40377579", @state="4", @stateTimestamp="2015-04-30 02:50:14", @onlineTimestamp="2014-12-20 00:48:19", @standingOwnerID="99004368">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfd12a558 @container={}, @attribs={}, @itemID="1016243377818", @typeID="20065", @locationID="31000510", @moonID="40377613", @state="4", @stateTimestamp="2015-04-30 03:12:22", @onlineTimestamp="2014-10-20 01:09:33", @standingOwnerID="98293472">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfd129b30 @container={}, @attribs={}, @itemID="1016243412298", @typeID="20065", @locationID="31000510", @moonID="40377607", @state="4", @stateTimestamp="2015-04-30 03:15:46", @onlineTimestamp="2014-10-20 01:13:07", @standingOwnerID="98293472">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfd1291a8 @container={}, @attribs={}, @itemID="1016243440548", @typeID="20065", @locationID="31000510", @moonID="40377608", @state="4", @stateTimestamp="2015-04-30 03:13:26", @onlineTimestamp="2014-10-20 01:10:43", @standingOwnerID="98293472">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfd128668 @container={}, @attribs={}, @itemID="1016243471219", @typeID="20065", @locationID="31000510", @moonID="40377605", @state="4", @stateTimestamp="2015-04-30 03:18:54", @onlineTimestamp="2014-10-20 01:16:03", @standingOwnerID="98293472">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfc27bcf0 @container={}, @attribs={}, @itemID="1016243868446", @typeID="27609", @locationID="31000510", @moonID="40377623", @state="4", @stateTimestamp="2015-04-30 03:05:43", @onlineTimestamp="2014-10-20 03:03:07", @standingOwnerID="99002824">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfc27b318 @container={}, @attribs={}, @itemID="1016269354241", @typeID="12235", @locationID="31000510", @moonID="40377617", @state="4", @stateTimestamp="2015-04-30 03:05:51", @onlineTimestamp="2014-10-27 07:02:18", @standingOwnerID="99002824">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfc27aa30 @container={}, @attribs={}, @itemID="1016347526754", @typeID="20065", @locationID="31000510", @moonID="40377603", @state="4", @stateTimestamp="2015-04-30 03:10:15", @onlineTimestamp="2014-11-02 22:07:17", @standingOwnerID="98293472">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfc27a148 @container={}, @attribs={}, @itemID="1016369889171", @typeID="12236", @locationID="31000510", @moonID="40377604", @state="4", @stateTimestamp="2015-04-30 03:05:00", @onlineTimestamp="2014-11-03 01:01:27", @standingOwnerID="99002824">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfc279770 @container={}, @attribs={}, @itemID="1016417085125", @typeID="12236", @locationID="31000510", @moonID="40377618", @state="4", @stateTimestamp="2015-04-30 03:03:57", @onlineTimestamp="2014-11-10 03:00:34", @standingOwnerID="98293472">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfc278e60 @container={}, @attribs={}, @itemID="1016435783726", @typeID="16213", @locationID="31000510", @moonID="40377601", @state="4", @stateTimestamp="2015-04-30 03:00:41", @onlineTimestamp="2014-11-09 22:57:02", @standingOwnerID="98293472">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfc278528 @container={}, @attribs={}, @itemID="1016435866479", @typeID="12236", @locationID="31000510", @moonID="40377609", @state="4", @stateTimestamp="2015-04-30 03:04:11", @onlineTimestamp="2014-11-09 23:00:37", @standingOwnerID="98293472">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfc273b18 @container={}, @attribs={}, @itemID="1016497897889", @typeID="12236", @locationID="31000510", @moonID="40377626", @state="4", @stateTimestamp="2015-04-30 03:20:18", @onlineTimestamp="2014-11-26 04:17:32", @standingOwnerID="98293472">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfc2730c8 @container={}, @attribs={}, @itemID="1016587324389", @typeID="12236", @locationID="31000510", @moonID="40377614", @state="4", @stateTimestamp="2015-04-30 03:16:34", @onlineTimestamp="2014-11-26 04:13:41", @standingOwnerID="98293472">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfc272060 @container={}, @attribs={}, @itemID="1016596532654", @typeID="12236", @locationID="31000510", @moonID="40377620", @state="4", @stateTimestamp="2015-04-30 03:03:43", @onlineTimestamp="2014-11-27 07:00:30", @standingOwnerID="98293472">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfc2712c8 @container={}, @attribs={}, @itemID="1016597084574", @typeID="12236", @locationID="31000510", @moonID="40377619", @state="4", @stateTimestamp="2015-04-30 03:03:18", @onlineTimestamp="2014-11-27 07:00:06", @standingOwnerID="98293472">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfc270a30 @container={}, @attribs={}, @itemID="1016646361321", @typeID="16213", @locationID="31000510", @moonID="40377615", @state="4", @stateTimestamp="2015-04-30 03:04:16", @onlineTimestamp="2014-12-04 05:00:18", @standingOwnerID="99002824">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfc270120 @container={}, @attribs={}, @itemID="1016983894931", @typeID="12235", @locationID="31000510", @moonID="40377610", @state="4", @stateTimestamp="2015-04-30 03:31:24", @onlineTimestamp="2015-01-06 07:29:45", @standingOwnerID="98293472">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfc26b850 @container={}, @attribs={}, @itemID="1017053056659", @typeID="20065", @locationID="31000510", @moonID="40377581", @state="4", @stateTimestamp="2015-04-30 03:32:11", @onlineTimestamp="2015-01-12 06:30:36", @standingOwnerID="99004368">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfc26af68 @container={}, @attribs={}, @itemID="1017054256595", @typeID="16213", @locationID="31000510", @moonID="40377599", @state="4", @stateTimestamp="2015-04-30 03:31:57", @onlineTimestamp="2015-01-12 07:28:21", @standingOwnerID="99004368">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfc26a5b8 @container={}, @attribs={}, @itemID="1017133288896", @typeID="12236", @locationID="31000510", @moonID="40377621", @state="4", @stateTimestamp="2015-04-30 03:04:14", @onlineTimestamp="2015-01-25 06:02:12", @standingOwnerID="98293472">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfc269c80 @container={}, @attribs={}, @itemID="1017288678123", @typeID="16213", @locationID="31000510", @moonID="40377597", @state="4", @stateTimestamp="2015-04-30 03:02:36", @onlineTimestamp="2015-02-09 03:00:53", @standingOwnerID="98293472">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfc2693c0 @container={}, @attribs={}, @itemID="1017678703873", @typeID="20065", @locationID="31000510", @moonID="40377586", @state="4", @stateTimestamp="2015-04-30 02:33:50", @onlineTimestamp="2015-03-18 05:33:21", @standingOwnerID="98293472">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfc268a38 @container={}, @attribs={}, @itemID="1017686966228", @typeID="20062", @locationID="31000510", @moonID="40377593", @state="1", @stateTimestamp="2015-03-19 03:14:59", @onlineTimestamp="0001-01-01 00:00:00", @standingOwnerID="98293472">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfc2681c8 @container={}, @attribs={}, @itemID="1017687073817", @typeID="20062", @locationID="31000510", @moonID="40377596", @state="1", @stateTimestamp="2015-03-19 03:16:56", @onlineTimestamp="0001-01-01 00:00:00", @standingOwnerID="98293472">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfc263b00 @container={}, @attribs={}, @itemID="1017687080649", @typeID="20062", @locationID="31000510", @moonID="40377568", @state="4", @stateTimestamp="2015-04-30 03:14:54", @onlineTimestamp="2015-04-15 01:14:40", @standingOwnerID="98293472">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfc2631f0 @container={}, @attribs={}, @itemID="1017687098092", @typeID="20062", @locationID="31000510", @moonID="40377570", @state="1", @stateTimestamp="2015-03-19 03:06:17", @onlineTimestamp="0001-01-01 00:00:00", @standingOwnerID="98293472">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfc262930 @container={}, @attribs={}, @itemID="1017687103638", @typeID="20062", @locationID="31000510", @moonID="40377571", @state="1", @stateTimestamp="2015-03-19 03:08:37", @onlineTimestamp="0001-01-01 00:00:00", @standingOwnerID="98293472">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfc262070 @container={}, @attribs={}, @itemID="1017687105160", @typeID="20062", @locationID="31000510", @moonID="40377589", @state="1", @stateTimestamp="2015-03-19 03:12:08", @onlineTimestamp="0001-01-01 00:00:00", @standingOwnerID="98293472">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfc261788 @container={}, @attribs={}, @itemID="1017687109843", @typeID="20062", @locationID="31000510", @moonID="40377588", @state="1", @stateTimestamp="2015-03-19 03:11:04", @onlineTimestamp="0001-01-01 00:00:00", @standingOwnerID="98293472">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfc260f40 @container={}, @attribs={}, @itemID="1017687112243", @typeID="20062", @locationID="31000510", @moonID="40377585", @state="1", @stateTimestamp="2015-03-19 03:22:27", @onlineTimestamp="0001-01-01 00:00:00", @standingOwnerID="98293472">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfc2606a8 @container={}, @attribs={}, @itemID="1017687118444", @typeID="20062", @locationID="31000510", @moonID="40377576", @state="1", @stateTimestamp="2015-03-19 03:10:12", @onlineTimestamp="0001-01-01 00:00:00", @standingOwnerID="98293472">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfd8c3e18 @container={}, @attribs={}, @itemID="1017687122937", @typeID="20062", @locationID="31000510", @moonID="40377584", @state="1", @stateTimestamp="2015-03-19 03:23:29", @onlineTimestamp="0001-01-01 00:00:00", @standingOwnerID="98293472">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfd8c3260 @container={}, @attribs={}, @itemID="1017687125798", @typeID="20062", @locationID="31000510", @moonID="40377577", @state="1", @stateTimestamp="2015-03-19 03:11:37", @onlineTimestamp="0001-01-01 00:00:00", @standingOwnerID="98293472">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfd8c2270 @container={}, @attribs={}, @itemID="1017687131701", @typeID="20062", @locationID="31000510", @moonID="40377578", @state="1", @stateTimestamp="2015-03-19 03:12:52", @onlineTimestamp="0001-01-01 00:00:00", @standingOwnerID="98293472">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfd8c0970 @container={}, @attribs={}, @itemID="1017687136621", @typeID="20062", @locationID="31000510", @moonID="40377595", @state="1", @stateTimestamp="2015-03-19 03:13:54", @onlineTimestamp="0001-01-01 00:00:00", @standingOwnerID="98293472">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfd8bb998 @container={}, @attribs={}, @itemID="1017687142915", @typeID="20062", @locationID="31000510", @moonID="40377580", @state="1", @stateTimestamp="2015-03-19 03:15:11", @onlineTimestamp="0001-01-01 00:00:00", @standingOwnerID="98293472">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfd8bb0b0 @container={}, @attribs={}, @itemID="1017687148726", @typeID="20062", @locationID="31000510", @moonID="40377591", @state="1", @stateTimestamp="2015-03-19 03:19:46", @onlineTimestamp="0001-01-01 00:00:00", @standingOwnerID="98293472">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfd8ba840 @container={}, @attribs={}, @itemID="1017687153300", @typeID="20062", @locationID="31000510", @moonID="40377582", @state="1", @stateTimestamp="2015-03-19 03:17:30", @onlineTimestamp="0001-01-01 00:00:00", @standingOwnerID="98293472">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfd8b9f30 @container={}, @attribs={}, @itemID="1017687155584", @typeID="20062", @locationID="31000510", @moonID="40377590", @state="1", @stateTimestamp="2015-03-19 03:17:48", @onlineTimestamp="0001-01-01 00:00:00", @standingOwnerID="98293472">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfd8b9558 @container={}, @attribs={}, @itemID="1017687156736", @typeID="20062", @locationID="31000510", @moonID="40377594", @state="1", @stateTimestamp="2015-03-19 03:18:04", @onlineTimestamp="0001-01-01 00:00:00", @standingOwnerID="98293472">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfd8b8c48 @container={}, @attribs={}, @itemID="1017687160668", @typeID="20062", @locationID="31000510", @moonID="40377592", @state="1", @stateTimestamp="2015-03-19 03:18:49", @onlineTimestamp="0001-01-01 00:00:00", @standingOwnerID="98293472">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfd8b8338 @container={}, @attribs={}, @itemID="1017687161146", @typeID="20062", @locationID="31000510", @moonID="40377583", @state="1", @stateTimestamp="2015-03-19 03:18:56", @onlineTimestamp="0001-01-01 00:00:00", @standingOwnerID="98293472">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfd123b90 @container={}, @attribs={}, @itemID="1017687172262", @typeID="20062", @locationID="31000510", @moonID="40377587", @state="1", @stateTimestamp="2015-03-19 03:21:12", @onlineTimestamp="0001-01-01 00:00:00", @standingOwnerID="98293472">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfd1232f8 @container={}, @attribs={}, @itemID="1017939981910", @typeID="16213", @locationID="31000510", @moonID="40377612", @state="4", @stateTimestamp="2015-04-30 03:28:09", @onlineTimestamp="2015-04-16 01:27:46", @standingOwnerID="98293472">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfd122a10 @container={}, @attribs={}, @itemID="1018023268351", @typeID="16213", @locationID="31000510", @moonID="40377574", @state="4", @stateTimestamp="2015-04-30 02:36:01", @onlineTimestamp="2015-04-26 01:35:56", @standingOwnerID="98293472">, #<CorpStarbaseListRowsetStarbasesRow:0x007fdbfd122100 @container={}, @attribs={}, @itemID="1010994826126", @typeID="16214", @locationID="31000520", @moonID="40378083", @state="1", @stateTimestamp="2015-03-21 06:05:03", @onlineTimestamp="0001-01-01 00:00:00", @standingOwnerID="99004368">]>
        pos_list.starbases
      end
    end

    def tower_names
      @tower_names ||= begin
        tower_ids = starbases.map(&:itemID)
        api.Locations(ids: tower_ids.join(",")).locations
      end
    end

    def find_or_initialize_tower(pos)
      Tower.where(item_id: pos.itemID.to_i).first_or_initialize do |t|
        t.type_id = pos.typeID.to_i
        t.state = pos.state.to_i
        t.name = tower_names.detect(->{ OpenStruct.new(itemName: '<not set>') }) { |p| p.itemID.to_i == pos.itemID.to_i }.itemName
      end
    end

    def find_or_create_moon(pos)
      # Find or create solar system
      solar_system = System.where(item_id: pos.locationID.to_i).first_or_create do |s|
        s.name = static_map_lookup_name(pos.locationID.to_i)
      end
      # Find or create moon
      Moon.where(item_id: pos.moonID.to_i).first_or_create do |m|
        m.system = solar_system
        moon_details = static_moon_info(pos.moonID.to_i)
        m.name = moon_details[:name]
        m.planet = moon_details[:planet]
        m.orbit = moon_details[:orbit]
      end
    end

    def add_fuel_to(tower)
      details = api.StarbaseDetail(itemID: tower.item_id)
      #<CorpStarbaseDetailResult:0x007fdbfd0d0940 @request_time="2015-04-30 02:38:40", @cached_until="2015-04-30 03:30:14", @state="1", @stateTimestamp="2015-04-20 06:46:21", @onlineTimestamp="0001-01-01 00:00:00", @generalSettings=#<EAAL::Result::ResultContainer:0x007fdbfc83b9b0 @container={"usageFlags"=>"5", "deployFlags"=>"64", "allowCorporationMembers"=>"1", "allowAllianceMembers"=>"1"}, @attribs={}>, @combatSettings=#<EAAL::Result::ResultContainer:0x007fdbfc839cf0 @container={"useStandingsFrom"=>#<EAAL::Result::ResultElement:0x007fdbfc839a70 @name="useStandingsFrom", @value="", @attribs={"ownerID"=>"98293472"}>, "onStandingDrop"=>#<EAAL::Result::ResultElement:0x007fdbfc839138 @name="onStandingDrop", @value="", @attribs={"standing"=>"0"}>, "onStatusDrop"=>#<EAAL::Result::ResultElement:0x007fdbfc838648 @name="onStatusDrop", @value="", @attribs={"enabled"=>"0", "standing"=>"0"}>, "onAggression"=>#<EAAL::Result::ResultElement:0x007fdbfd0d3d98 @name="onAggression", @value="", @attribs={"enabled"=>"0"}>, "onCorporationWar"=>#<EAAL::Result::ResultElement:0x007fdbfd0d3528 @name="onCorporationWar", @value="", @attribs={"enabled"=>"0"}>}, @attribs={}>, @fuel=[#<CorpStarbaseDetailRowsetFuelRow:0x007fdbfd0d18b8 @container={}, @attribs={}, @typeID="24593", @quantity="167">, #<CorpStarbaseDetailRowsetFuelRow:0x007fdbfd0d15e8 @container={}, @attribs={}, @typeID="4051", @quantity="1670">]>
      details.fuel.each do |fuel|
        # 16275 is the itemID for Strontium Clathrates
        if fuel.typeID.to_i == 16275
          tower.strontium = fuel.quantity
        else
          tower.fuel_blocks = fuel.quantity
        end
      end
      tower
    end

    def static_map_lookup_name(id)
      denormalized_lookup(id).itemName
    end

    def static_moon_info(id)
      result = denormalized_lookup(id)
      { name: result.itemName, planet: result.celestialIndex, orbit: result.orbitIndex }
    end

    def denormalized_lookup(id)
      # SELECT * FROM mapDenormalize WHERE mapDenormalize.itemID = 30000125
      Static::MapDenormalize.find_by(itemID: id)
    end

    def api
      EAAL::API.new(Rails.application.secrets.xml_api_corp_id, Rails.application.secrets.xml_api_corp_vcode, "corp")
    end
  end
end
