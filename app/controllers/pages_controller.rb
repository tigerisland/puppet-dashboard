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
        :label => 'unresponsive',
        :count => @no_longer_reporting_nodes.count + @unreported_nodes.count,
      },
      {
        :label => 'failed',
        :count => @currently_failing_nodes.count,
      },
#       {
#         :label => 'out-of-audit', # need to define exactly what this is
#         :count => 0,
#       },
      {
        :label => 'pending', # need real data access API
        :count => 22,
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
  end

  def release_notes
  end
end
