// Copyright Verizon Media. Licensed under the terms of the Apache 2.0 license. See LICENSE in the project root.
package com.yahoo.vespa.hosted.controller.api.integration.noderepository;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.yahoo.vespa.hosted.controller.api.integration.configserver.Cluster;

import java.time.Instant;

/**
 * Utilization ratios
 *
 * @author bratseth
 */
@JsonIgnoreProperties(ignoreUnknown = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ClusterUtilizationData {

    @JsonProperty("cpu")
    public Double cpu;

    @JsonProperty("memory")
    public Double memory;

    @JsonProperty("disk")
    public Double disk;

    public Cluster.Utilization toClusterUtilization() {
        return new Cluster.Utilization(cpu, memory, disk);
    }

}
