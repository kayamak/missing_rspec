require "rake"

RSpec.describe do
  before(:all) do
    @rake = Rake::Application.new
    Rake.application = @rake

    # This line require file e.g '/app/lib/tasks/missing_rspec.rake'
    # Rake.application.rake_require('missing_rspec', [Rails.root.join('lib', 'tasks')])
    Rake.application.rake_require('missing_rspec', ['lib/tasks'])

    Rake::Task.define_task(:environment)
  end

  before(:each) do
    @rake[task].reenable
  end

  describe  do
    let(:task) { 'missing_rspec' }

    context 'When app_path is specified as an argument to rake' do
      it 'does not result in an error after execution' do
        expect(@rake[task].invoke('/app')).to be_truthy
      end
    end
    context 'If no rake arguments are specified' do 
      context "If ENV['RAILS_APP_PATH'] is not set" do
        it 'results in an error after execution' do
          expect{ @rake[task].invoke } .to raise_error("Set the rails app path to the rake argument or the environment variable RAILS_APP_PATH.")
        end
      end
      context "If ENV['RAILS_APP_PATH'] is set" do
        before do
          allow(ENV).to receive(:[]).with('RAILS_APP_PATH').and_return('/app')
        end

        it 'does not result in an error after execution' do
          expect(@rake[task].invoke).to be_truthy
        end
      end
    end
  end
end