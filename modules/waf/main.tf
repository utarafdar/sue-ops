# Create WAF Web ACL
resource "aws_wafv2_web_acl" "waf_acl" {
  name        = var.name
  description = var.description
  scope       = "REGIONAL" # Use REGIONAL for ALBs (Elastic Beanstalk uses ALBs)

  default_action {
    allow {}
  }

  rule {
    name     = "block-bots"
    priority = 1

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesBotControlRuleSet"
        vendor_name = "AWS"
        managed_rule_group_configs {
          aws_managed_rules_bot_control_rule_set {
            inspection_level = "COMMON"
          }
        }
      }
    }

    visibility_config {
      sampled_requests_enabled   = true
      cloudwatch_metrics_enabled = true
      metric_name                = "block-bots"
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "waf-acl"
    sampled_requests_enabled   = true
  }
}

# Associate WAF Web ACL with a Load Balancer
resource "aws_wafv2_web_acl_association" "waf_acl_association" {
  resource_arn = var.resource_arn
  web_acl_arn  = aws_wafv2_web_acl.waf_acl.arn
}