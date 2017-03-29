require 'spec_helper'

describe 'profile_telegraf' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts.merge({
            :concat_basedir => "/foo"
          })
        end

        context "profile_telegraf class without any parameters" do
          let(:params) {{ }}

          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_class('profile_telegraf') }
          it { is_expected.to contain_class('profile_telegraf::params') }
          it { is_expected.to contain_class('profile_telegraf::install') }
          it { is_expected.to contain_class('profile_telegraf::config') }
          it { is_expected.to contain_class('profile_telegraf::service') }
          it { is_expected.to contain_class('telegraf') }

          it { is_expected.to contain_telegraf__input('cpu') }
          it { is_expected.to contain_telegraf__input('disk') }
          it { is_expected.to contain_telegraf__input('diskio') }
          it { is_expected.to contain_telegraf__input('internal') }
          it { is_expected.to contain_telegraf__input('kernel') }
          it { is_expected.to contain_telegraf__input('mem') }
          it { is_expected.to contain_telegraf__input('net') }
          it { is_expected.to contain_telegraf__input('netstat') }
          it { is_expected.to contain_telegraf__input('processes') }
          it { is_expected.to contain_telegraf__input('swap') }
          it { is_expected.to contain_telegraf__input('system') }

        end
      end
    end
  end
end
