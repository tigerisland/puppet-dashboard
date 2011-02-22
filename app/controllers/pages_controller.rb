class PagesController < ApplicationController

  def home
    @currently_failing_nodes = Node.by_currentness_and_successfulness(true, false).unhidden
    @unreported_nodes = Node.unreported.unhidden
    @no_longer_reporting_nodes = Node.no_longer_reporting.unhidden
    @recently_reported_nodes = Node.reported.by_report_date.unhidden.all(:limit => 10)

    @unhidden_nodes = Node.unhidden

    # XXX this is temporary mockup data
    # aww yeah, brute force FTW
    @node_summaries = [
      {
        :label => 'failed',
        :count => @currently_failing_nodes.count,
      },
      {
        :label => 'out-of-audit', # need to define exactly what this is
        :count => 6,
      },
      {
        :label => 'pending', # need real data access API
        :count => 22,
      },
      {
        :label => 'unresponsive',
        :count => @no_longer_reporting_nodes.count + @unreported_nodes.count,
      },
      {
        :label => 'compliant', # needs to wait on the above two
        :count => 109,
      },
    ]
    @total_nodes = @unhidden_nodes.count
    @node_summaries.each do |n| # round to one decimal
      n[ :percent ] = (( n[ :count ].to_f / @total_nodes.to_f ) * 1000 ).round.to_f / 10
    end

    @hostnames = %w[ antiendotoxin ropery irreverendly Hasidic themata bassorin sulphanilate schematogram antitrust millage endothecial auriform flatway grouchily detachable ceruminal backfatter biriba ackman Trixy pushwainling Insessores epistolize apomecometer taxi scratchlike intellectually brewer dankish measondue advertising Titanichthyidae thoracohumeral cascara compilement hackle thonged euphory olease messieurs pounding Welshery tesseraic celiomyalgia sornare Talaing cinchotine trichromic simpleheartedness bra ]
    @statuses = %w[ unresponsive failed pending compliant ]
    @host_summaries = []
    @hostnames.each do |h|
      @host_summaries.push({
        :host => h,
        :status => @statuses[ rand( @statuses.count )],
        :failed => 1,
        :pending => 2,
        :compliant => 3,
      })
    end
  end

  def release_notes
  end
end
