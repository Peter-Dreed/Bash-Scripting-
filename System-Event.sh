#!/bin/bash

# Configuration
LOG_DIR="./logs"
LOG_FILE="$LOG_DIR/security_analysis.log"
AUTH_LOG="/var/log/auth.log"  # Updated to standard auth log path
SYS_LOG="/var/log/syslog"     # Updated to standard syslog path
CSV_REPORT="$LOG_DIR/security_report.csv"

# Create directories if missing
mkdir -p "$LOG_DIR"

# Enhanced logging function
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

# Initialize CSV report
init_report() {
    echo "Timestamp,Failed_SSH,System_Errors,Suspicious_Users,Root_Access,High_Alerts" > "$CSV_REPORT"
}

# Enhanced security analysis function
analyze_logs() {
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    # SSH analysis
    local failed_logins=$(grep "Failed password" "$AUTH_LOG" | wc -l)
    local suspicious_users=$(grep "Invalid user" "$AUTH_LOG" | awk '{print $8}' | sort | uniq -c | tr '\n' ';')
    
    # Privilege escalation checks
    local root_access=$(grep "session opened for user root" "$AUTH_LOG" | wc -l)
    
    # Error analysis with priority levels
    local critical_errors=$(grep -i "CRITICAL" "$SYS_LOG" | wc -l)
    local high_errors=$(grep -i "ERROR" "$SYS_LOG" | wc -l)
    local total_errors=$((critical_errors + high_errors))

    # Generate CSV line
    echo "$timestamp,$failed_logins,$total_errors,\"$suspicious_users\",$root_access,$critical_errors" >> "$CSV_REPORT"

    # Terminal alerts
    [ "$failed_logins" -gt 5 ] && log " SSH Alert: $failed_logins failed login attempts"
    [ "$critical_errors" -gt 3 ] && log " Critical System Errors: $critical_errors"
    [ "$root_access" -gt 2 ] && log " Root Access Alert: $root_access root sessions"
}

# Main execution
init_report
log "===== Security Analysis Started ====="
analyze_logs
log "===== Analysis Complete ====="
log "CSV Report Generated: $CSV_REPORT"