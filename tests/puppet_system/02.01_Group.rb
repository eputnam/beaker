
# Write new class to init.pp
prep_initpp(master, "group")

step "Group Resource: puppet agent --no-daemonize --verbose --onetime --test"
run_agent_on agents

step "Verify Group Existence on Agents"
agents.each { |agent|
  on agent,'cat /etc/group | grep -c puppetgroup'
  if result.stdout =~ /3/ then
    puts "Group created correctly"
  else
    puts "Error creating group"
    @fail_flag+=1
  end
}
