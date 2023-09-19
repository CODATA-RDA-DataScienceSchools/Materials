library(tidyverse)
interviews_plotting <- read_csv("data_output/interviews_plotting.csv")

interviews_plotting %>%
  ggplot(aes(x = no_membrs, y = number_items)) +
  geom_point()

# Assign plot to a variable
interviews_plot <- interviews_plotting %>%
  ggplot(aes(x = no_membrs, y = number_items))

# Draw the plot as a dot plot
interviews_plot +
  geom_point(colour="blue")

interviews_plotting %>%
  ggplot(aes(x = no_membrs, y = number_items)) +
  geom_jitter()

interviews_plotting %>%
  ggplot(aes(x = no_membrs, y = number_items)) +
  geom_jitter(alpha = 0.3,
              width = 0.2,
              height = 0.2, 
              color = "blue")

interviews_plotting %>%
  ggplot(aes(x = no_membrs, y = number_items)) +
  geom_jitter(aes(color = village), 
              alpha = 0.3, width = 0.2, height = 0.2)

interviews_plotting %>%
  ggplot(aes(x = no_membrs, y = number_items, 
             color = village)) +
  geom_count()


interviews_plotting %>%
  ggplot(aes(x = village, y = rooms)) +
  geom_jitter(aes(color = respondent_wall_type),
              alpha = 0.3,
              width = 0.2,
              height = 0.2)

interviews_plotting %>%
  ggplot(aes(x = respondent_wall_type, y = rooms)) +
  geom_boxplot()

interviews_plotting %>%
  ggplot(aes(x = respondent_wall_type, y = rooms)) +
  geom_boxplot(alpha = 0) +
  geom_jitter(alpha = 0.3,
              color = "tomato",
              width = 0.2,
              height = 0.2)

interviews_plotting %>%
  ggplot(aes(x = respondent_wall_type, y = rooms)) +
  geom_violin(alpha = 0) +
  geom_jitter(alpha = 0.5, color = "tomato")

interviews_plotting %>%
  ggplot(aes(x = respondent_wall_type, y = liv_count)) +
  geom_boxplot(alpha = 0) +
  geom_jitter(alpha = 0.5, width = 0.2, height = 0.2)

interviews_plotting %>%
  ggplot(aes(x = respondent_wall_type, y = liv_count)) +
  geom_boxplot(alpha = 0) +
  geom_jitter(aes(color = memb_assoc), 
              alpha = 0.5, width = 0.2, height = 0.2)

interviews_plotting %>%
  ggplot(aes(x = respondent_wall_type)) +
  geom_bar()

interviews_plotting %>%
  ggplot(aes(x = respondent_wall_type)) +
  geom_bar(aes(fill = village))

interviews_plotting %>%
  ggplot(aes(x = respondent_wall_type)) +
  geom_bar(aes(fill = village), position = "dodge")

percent_wall_type <- interviews_plotting %>%
  filter(respondent_wall_type != "cement") %>%
  count(village, respondent_wall_type) %>%
  group_by(village) %>%
  mutate(percent = (n / sum(n)) * 100) %>%
  ungroup()

percent_wall_type %>%
  ggplot(aes(x = village, y = percent, fill = respondent_wall_type)) +
  geom_bar(stat = "identity", position = "dodge")

percent_memb_assoc <- interviews_plotting %>%
  filter(!is.na(memb_assoc)) %>%
  count(village, memb_assoc) %>%
  group_by(village) %>%
  mutate(percent = (n / sum(n)) * 100) %>%
  ungroup()

percent_memb_assoc %>%
  ggplot(aes(x = village, y = percent, 
             fill = memb_assoc)) +
  geom_bar(stat = "identity", position = "dodge")


percent_wall_type %>%
  ggplot(aes(x = village, y = percent, 
             fill = respondent_wall_type)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Proportion of wall type by village",
       fill = "Type of Wall in Home",
       x = "Village",
       y = "Percent")

percent_wall_type %>%
  ggplot(aes(x = respondent_wall_type, y = percent)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title="Proportion of wall type by village",
       x="Wall Type",
       y="Percent") +
  facet_wrap(~ village)

percent_wall_type %>%
  ggplot(aes(x = respondent_wall_type, y = percent)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title="Proportion of wall type by village",
       x="Wall Type",
       y="Percent") +
  facet_wrap(~ village) +
  theme_bw() +
  theme(panel.grid = element_blank())

percent_items <- interviews_plotting %>%
  group_by(village) %>%
  summarize(across(bicycle:no_listed_items, ~ sum(.x) / n() * 100)) %>%
  pivot_longer(bicycle:no_listed_items, 
               names_to = "items", values_to = "percent")

percent_items %>%
  ggplot(aes(x = village, y = percent)) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_wrap(~ items) +
  theme_bw() +
  theme(panel.grid = element_blank())

percent_items %>%
  ggplot(aes(x = village, y = percent)) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_wrap(~ items) +
  labs(title = "Percent of respondents in each village who owned each item",
       x = "Village",
       y = "Percent of Respondents") +
  theme_bw()

percent_items %>%
  ggplot(aes(x = village, y = percent)) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_wrap(~ items) +
  labs(title = "Percent of respondents in each village who owned each item",
       x = "Village",
       y = "Percent of Respondents") +
  theme_bw() +
  theme(text = element_text(size = 6))

percent_items %>%
  ggplot(aes(x = village, y = percent)) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_wrap(~ items) +
  labs(title = "Percent of respondents in each village \n who owned each item",
       x = "Village",
       y = "Percent of Respondents") +
  theme_bw() +
  theme(axis.text.x = element_text(colour = "grey20", size = 12, angle = 45,
                                   hjust = 0.5, vjust = 0.5),
        axis.text.y = element_text(colour = "grey20", size = 12),
        text = element_text(size = 16))


grey_theme <- theme(axis.text.x = element_text(colour = "grey20", size = 12,
                                               angle = 45, hjust = 0.5,
                                               vjust = 0.5),
                    axis.text.y = element_text(colour = "grey20", size = 12),
                    text = element_text(size = 16),
                    plot.title = element_text(hjust = 0.5))


percent_items %>%
  ggplot(aes(x = village, y = percent)) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_wrap(~ items) +
  labs(title = "Percent of respondents in each village \n who owned each item",
       x = "Village",
       y = "Percent of Respondents") +
  grey_theme


my_plot <- percent_items %>%
  ggplot(aes(x = village, y = percent)) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_wrap(~ items) +
  labs(title = "Percent of respondents in each village \n who owned each item",
       x = "Village",
       y = "Percent of Respondents") +
  theme_bw() +
  theme(axis.text.x = element_text(color = "grey20", size = 12, angle = 45,
                                   hjust = 0.5, vjust = 0.5),
        axis.text.y = element_text(color = "grey20", size = 12),
        text = element_text(size = 16),
        plot.title = element_text(hjust = 0.5))

ggsave("fig_output/name_of_file.png", my_plot, width = 15, height = 10)
