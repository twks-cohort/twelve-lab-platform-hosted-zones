require 'awspec'

describe route53_hosted_zone('cdicohorts-twelve.') do
  it { should exist }
end

describe route53_hosted_zone('nonprod_us_east_2_cdicohorts_twelve.com') do
  it { should exist }
end

describe route53_hosted_zone('dev_cohorts_twelve.com') do
  it { should exist }
end

describe route53_hosted_zone('prod_cohorts_twelve.com') do
  it { should exist }
end

describe route53_hosted_zone('qa_cohorts_twelve.com') do
  it { should exist }
end

describe route53_hosted_zone('nonprod_us_east_1_cdicohorts_twelve.com') do
  it { should exist }
end
