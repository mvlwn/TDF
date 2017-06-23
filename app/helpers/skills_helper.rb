module SkillsHelper

  def skill(category, value)
    content_tag :span, class: "skill#{value.to_i == 5 ? ' skill--highlight' : nil }" do
      skill_category(category) + ' '.html_safe + skill_value(value)
    end
  end

  def skill_category(category)
    content_tag(:span, category, class: 'skill-category')
  end

  def skill_value(value)
    content_tag(:span, value, class: "skill-value")
  end

end