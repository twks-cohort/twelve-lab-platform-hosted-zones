require 'awspec'

describe route53_hosted_zone('cdicohorts-twelve.com') do
  it { should exist }
end

describe route53_hosted_zone('nonprod-us-east-2.cdicohorts-twelve.com') do
  it { should exist }
end

describe route53_hosted_zone('dev.cdicohorts-twelve.com') do
  it { should exist }
end


describe route53_hosted_zone('qa.cdicohorts-twelve.com') do
  it { should exist }
end
