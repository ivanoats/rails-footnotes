require "#{File.dirname(__FILE__)}/abstract_note"

module Footnotes
  module Notes
    class RpmNote < AbstractNote
      def initialize(controller)
        if defined?(NewRelic)
          @rpm_id=NewRelic::Agent.instance.transaction_sampler.current_sample_id
        end
      end

      def row
        :edit
      end

      def link
         #{:controller => 'newrelic', :action => 'show_sample_detail', :id => @rpm_id}
         "/newrelic/show_sample_detail/#{@rpm_id}" if @rpm_id
      end
      
      def valid?
        if defined?(NewRelic)
          if defined?(NewRelic::Control)
            !NewRelic::Control.instance['skip_developer_route']
          else
            !NewRelic::Config.instance['skip_developer_route']
          end
        else
          false
        end
      end
    end
  end
end
